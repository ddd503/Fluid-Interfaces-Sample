//
//  PresentTransitionAnimator.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/17.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class PresentTransitionAnimator: NSObject {
    weak var presenting: SourceTransitionType!
    weak var presented: DestinationTransitionType!
    private let duration: TimeInterval
    var presentAnimationInteractor: PresentAnimationInteractor?

    init(presenting: SourceTransitionType, presented: DestinationTransitionType,
         duration: TimeInterval, presentAnimationInteractor: PresentAnimationInteractor? = nil) {
        self.presenting = presenting
        self.presented = presented
        self.duration = duration
        self.presentAnimationInteractor = presentAnimationInteractor
    }
}

extension PresentTransitionAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let containerView = transitionContext.containerView
//
//        containerView.addSubview(presented.view)
//
//        presented.view.layoutIfNeeded()
//        let baseView = UIView(frame: presenting.baseView.frame)
//        baseView.backgroundColor = presenting.view.backgroundColor
//        let imageView = UIImageView(image: presenting.imageView.image)
//        imageView.frame = presenting.imageView.frame
//        baseView.addSubview(imageView)
//        let infomationImageView = presenting.infomationView.snapshotView(afterScreenUpdates: true) ?? UIView()
//        infomationImageView.frame = presenting.infomationView.frame
//        baseView.addSubview(infomationImageView)
//        containerView.addSubview(baseView)
//
//        let presentedLabelFrame = presented.labelView.convert(presented.label.frame, to: presented.view)
//        let label = UILabel(frame: presentedLabelFrame)
//        label.frame.origin.x = presentedLabelFrame.origin.x * 2.5
//        label.text = presented.label.text
//        label.font = presented.label.font
//        label.textColor = presenting.label.textColor
//        label.alpha = 0
//        containerView.addSubview(label)
//
//        let animator = UIViewPropertyAnimator(duration: duration, curve: .linear) { [weak self] in
//            guard let self = self else { return }
//            baseView.frame = self.presented.labelView.frame
//            imageView.frame.origin.y = self.presented.imageView.frame.origin.y
//            infomationImageView.alpha = 0
//        }
//
//        // 遅延実行アニメーションを追加
//        animator.addAnimations({ [weak self] in
//            guard let self = self else { return }
//            imageView.frame.origin.x = self.presented.imageView.frame.origin.x
//            imageView.frame.size = self.presented.imageView.frame.size
//        }, delayFactor: 0.5)
//
//        animator.addAnimations({
//            label.frame = presentedLabelFrame
//            label.alpha = 1.0
//        }, delayFactor: 0.8)
//
//        // 完了後処理を追加
//        animator.addCompletion { (_) in
//            baseView.removeFromSuperview()
//            label.removeFromSuperview()
//            let isComplete = !transitionContext.transitionWasCancelled
//            transitionContext.completeTransition(isComplete)
//        }
//
//        animator.startAnimation()
    }
}
