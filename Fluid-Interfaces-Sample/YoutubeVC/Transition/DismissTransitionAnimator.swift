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
        }) { (_) in
            animationView.removeFromSuperview()
            label.removeFromSuperview()
            let isComplete = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(isComplete)
        }
    }
}

