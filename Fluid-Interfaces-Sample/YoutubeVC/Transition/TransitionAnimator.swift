//
//  TransitionAnimator.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/06.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class TransitionAnimator: NSObject {
    let presenting: SourceTransitionType
    let presented: DestinationTransitionType
    let isPresent: Bool
    let duration: TimeInterval
    var pushAnimationInteractor: PushAnimationInteractor?
    var popAnimationInteractor: PopAnimationInteractor?

    init(presenting: SourceTransitionType, presented: DestinationTransitionType,
         isPresent: Bool, duration: TimeInterval, interactiveTransition: UIPercentDrivenInteractiveTransition) {
        self.presenting = presenting
        self.presented = presented
        self.isPresent = isPresent
        self.duration = duration
        self.pushAnimationInteractor = interactiveTransition as? PushAnimationInteractor
        self.popAnimationInteractor = interactiveTransition as? PopAnimationInteractor
    }

    func pushTransitionAnimation(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        containerView.addSubview(presented.view)
        presented.view.layoutIfNeeded()

        let baseView = UIView(frame: presenting.baseView.frame)
        baseView.backgroundColor = .darkGray
        let imageView = UIImageView(image: presenting.imageView.image)
        imageView.frame = presenting.imageView.frame
        baseView.addSubview(imageView)
        let infomationImageView = presenting.infomationView.snapshotView(afterScreenUpdates: true) ?? UIView()
        infomationImageView.frame = presenting.infomationView.frame
        baseView.addSubview(infomationImageView)
        containerView.addSubview(baseView)

        let presentedLabelFrame = presented.labelView.convert(presented.label.frame, to: presented.view)
        let label = UILabel(frame: presentedLabelFrame)
        label.frame.origin.x = presentedLabelFrame.origin.x * 2.5
        label.text = presented.label.text
        label.font = presented.label.font
        label.textColor = presenting.label.textColor
        label.alpha = 0
        containerView.addSubview(label)

        let animator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
            baseView.frame = self.presented.labelView.frame
            imageView.frame.origin.y = self.presented.imageView.frame.origin.y
            infomationImageView.alpha = 0
        }

        // 遅延実行アニメーションを追加
        animator.addAnimations({
            imageView.frame.origin.x = self.presented.imageView.frame.origin.x
            imageView.frame.size = self.presented.imageView.frame.size
        }, delayFactor: 0.5)

        animator.addAnimations({
            label.frame = presentedLabelFrame
            label.alpha = 1.0
        }, delayFactor: 0.8)

        // 完了後処理を追加
        animator.addCompletion { (_) in
            baseView.removeFromSuperview()
            label.removeFromSuperview()
            let isComplete = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(isComplete)
        }

        animator.startAnimation()
    }

    func popTranshitionAnimation(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        containerView.insertSubview(presenting.view, at: 0)
        let animationView = UIView(frame: presented.labelView.frame)
        animationView.backgroundColor = .darkGray
        let labelView = UIView(frame: .zero)
        labelView.frame.size = presented.labelView.frame.size
        labelView.backgroundColor = .clear
        animationView.addSubview(labelView)
        let imageView = UIImageView(image: presented.imageView.image)
        imageView.frame = presented.imageView.frame
        labelView.addSubview(imageView)
        let infomationView = presenting.infomationView.snapshotView(afterScreenUpdates: true) ?? UIView()
        infomationView.alpha = 0
        infomationView.frame.origin.y = presented.labelView.frame.height
        labelView.addSubview(infomationView)
        let label = presented.label.snapshotView(afterScreenUpdates: true) ?? UIView()
        label.frame = presented.label.frame
        labelView.addSubview(label)
        containerView.addSubview(animationView)


        UIView.animate(withDuration: duration / 3) {
            label.alpha = 0
        }

        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let self = self else {
                transitionContext.cancelInteractiveTransition()
                return
            }
            animationView.frame = self.presenting.view.frame
            labelView.frame = self.presenting.baseView.frame
            imageView.frame = self.presenting.imageView.frame
            infomationView.frame = self.presenting.infomationView.frame
            infomationView.alpha = 1
        }) { [weak self] (_) in
            animationView.removeFromSuperview()
            self?.presented.view.removeFromSuperview()
            label.removeFromSuperview()
            let isComplete = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(isComplete)
        }
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
