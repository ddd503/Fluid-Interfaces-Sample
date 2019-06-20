//
//  DismissTransitionAnimator.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/17.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class DismissTransitionAnimator: NSObject {
    weak var presenting: SourceTransitionType!
    weak var presented: DestinationTransitionType!
    private let duration: TimeInterval
    var dismissAnimationInteractor: DismissAnimationInteractor?

    init(presenting: SourceTransitionType, presented: DestinationTransitionType,
         duration: TimeInterval, dismissAnimationInteractor: DismissAnimationInteractor? = nil) {
        self.presenting = presenting
        self.presented = presented
        self.duration = duration
        self.dismissAnimationInteractor = dismissAnimationInteractor
    }
}

extension DismissTransitionAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        containerView.insertSubview(presenting.view, at: 0)
        presented.view.alpha = 0

        let baseView = UIView(frame: presented.baseView.frame)
        baseView.backgroundColor = presented.baseView.backgroundColor
        let imageView = UIImageView(image: presented.imageView.image)
        imageView.frame = presented.imageView.frame
        baseView.addSubview(imageView)
        let infomationImageView = presented.infomationView.snapshotView(afterScreenUpdates: true) ?? UIView()
        infomationImageView.frame = presented.infomationView.frame
        baseView.addSubview(infomationImageView)
        containerView.addSubview(baseView)

        let presentedLabelFrame = presenting.labelView.convert(presented.label.frame, to: presented.view)
        let label = UILabel(frame: presentedLabelFrame)
        label.frame.origin.x = presentedLabelFrame.origin.x * 2.5
        label.text = presented.label.text
        label.font = presented.label.font
        label.textColor = presenting.label.textColor
        label.alpha = 0
        containerView.addSubview(label)

        presenting.labelView.backgroundColor = .darkGray
        presenting.imageView.image = presented.imageView.image
        presenting.label.text = presented.label.text
        presenting.labelView.alpha = 0

        let animator = UIViewPropertyAnimator(duration: duration, curve: .linear) { [weak self] in
            guard let self = self else { return }
            baseView.frame = self.presenting.labelView.frame
            imageView.frame.origin.y = self.presenting.imageView.frame.origin.y
            infomationImageView.alpha = 0
        }

        // 遅延実行アニメーションを追加
        animator.addAnimations({ [weak self] in
            guard let self = self else { return }
            imageView.frame.origin.x = self.presenting.imageView.frame.origin.x
            imageView.frame.size = self.presenting.imageView.frame.size
            }, delayFactor: 0.5)

        animator.addAnimations({
            label.frame = presentedLabelFrame
            label.alpha = 1.0
        }, delayFactor: 0.8)

        // 完了後処理を追加
        animator.addCompletion { [weak self] (_) in
            baseView.removeFromSuperview()
            label.removeFromSuperview()
            self?.presenting.labelView.alpha = 1.0
            let isComplete = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(isComplete)
        }

        animator.startAnimation()
    }
}

