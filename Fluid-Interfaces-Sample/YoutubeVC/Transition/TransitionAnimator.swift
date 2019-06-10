//
//  TransitionAnimator.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/06.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit
final class TransitionAnimator: NSObject {
    weak var presenting: SourceTransitionType!
    weak var presented: DestinationTransitionType!
    let isPresent: Bool
    let duration: TimeInterval

    init(presenting: SourceTransitionType, presented: DestinationTransitionType, isPresent: Bool, duration: TimeInterval) {
        self.presenting = presenting
        self.presented = presented
        self.isPresent = isPresent
        self.duration = duration
    }

    func pushTransitionAnimation(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        containerView.addSubview(presented.view)
        presented.view.layoutIfNeeded()
        presented.view.alpha = 0

        let animationView = UIView(frame: presenting.labelView.frame)
        animationView.backgroundColor = .darkGray
        let baseView = UIView(frame: .zero)
        baseView.frame.size = presenting.labelView.frame.size
        baseView.backgroundColor = .clear
        let imageView = UIImageView(image: presenting.imageView.image)
        imageView.frame = presenting.imageView.frame
        baseView.addSubview(imageView)
        let infomationImageView = presented.infomationView.snapshotView(afterScreenUpdates: true) ?? UIView()
        infomationImageView.frame = presented.infomationView.frame
        infomationImageView.alpha = 0
        baseView.addSubview(infomationImageView)
        animationView.addSubview(baseView)
        containerView.addSubview(animationView)

        let label = UILabel(frame: presenting.labelView.convert(presenting.label.frame, to: presenting.view))
        label.text = presenting.label.text
        label.font = presenting.label.font
        label.textColor = presenting.label.textColor
        containerView.addSubview(label)

        UIView.animate(withDuration: duration / 3) {
            label.alpha = 0
        }

        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let self = self else {
                transitionContext.cancelInteractiveTransition()
                return
            }
            animationView.frame = self.presented.view.frame
            baseView.frame = self.presented.baseView.frame
            imageView.frame = self.presented.imageView.frame
            infomationImageView.alpha = 1.0
        }) { [weak self] (_) in
            self?.presented.view.alpha = 1.0
            animationView.removeFromSuperview()
            label.removeFromSuperview()
            let isComplete = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(isComplete)
        }
    }

    func popTranshitionAnimation(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        containerView.insertSubview(presenting.view, at: 0)
        presented.view.alpha = 0

        let animationView = UIView(frame: presented.view.frame)
        animationView.backgroundColor = .darkGray
        let baseView = UIView(frame: presented.baseView.frame)
        baseView.backgroundColor = .clear
        animationView.addSubview(baseView)
        let imageView = UIImageView(image: presented.imageView.image)
        imageView.frame = presented.baseView.convert(presented.imageView.frame, to: presented.view)
        animationView.addSubview(imageView)
        let infomationImageView = presented.infomationView.snapshotView(afterScreenUpdates: true) ?? UIView()
        infomationImageView.frame = presented.baseView.convert(presented.infomationView.frame, to: presented.view)
        animationView.addSubview(infomationImageView)
        containerView.addSubview(animationView)

        let label = UILabel(frame: presenting.labelView.convert(presenting.label.frame, to: presenting.view))
        label.text = presenting.label.text
        label.font = presenting.label.font
        label.textColor = presenting.label.textColor
        label.alpha = 0
        containerView.addSubview(label)

        let animator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
            animationView.frame = self.presenting.labelView.frame
            imageView.frame.origin.y = self.presenting.imageView.frame.origin.y
            infomationImageView.alpha = 0
        }

        // 遅延実行アニメーションを追加
        animator.addAnimations({
            imageView.frame.origin.x = self.presenting.imageView.frame.origin.x
            imageView.frame.size = self.presenting.imageView.frame.size
        }, delayFactor: 0.5)

        animator.addAnimations({
            label.alpha = 1.0
        }, delayFactor: 0.8)

        // 完了後処理を追加
        animator.addCompletion { (_) in
            animationView.removeFromSuperview()
            label.removeFromSuperview()
            let isComplete = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(isComplete)
        }

        animator.startAnimation()
    }
}

extension TransitionAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresent ? pushTransitionAnimation(transitionContext: transitionContext) : popTranshitionAnimation(transitionContext: transitionContext)
    }
}
