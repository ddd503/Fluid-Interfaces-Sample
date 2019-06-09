//
//  TransitionAnimator.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/06.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit
final class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    weak var presenting: SourceTransitionType!
    weak var presented: DestinationTransitionType!
    let isPushTransition: Bool
    let duration: TimeInterval

    init(presenting: SourceTransitionType, presented: DestinationTransitionType, isPushTransition: Bool, duration: TimeInterval) {
        self.presenting = presenting
        self.presented = presented
        self.isPushTransition = isPushTransition
        self.duration = duration
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        containerView.addSubview(presented.view)
        presented.view.layoutIfNeeded()
        presented.view.alpha = 0

        let baseView = UIView(frame: .zero)
        baseView.backgroundColor = .darkGray
        baseView.frame.size = presenting.labelView.frame.size
        baseView.frame.origin = presenting.labelView.frame.origin
        let imageView = UIImageView(image: presenting.imageView.image)
        imageView.frame = presenting.imageView.frame
        baseView.addSubview(imageView)
        let infomationImageView = presented.infomationView.snapshotView(afterScreenUpdates: true) ?? UIView()
        infomationImageView.frame = presented.infomationView.frame
        infomationImageView.alpha = 0
        baseView.addSubview(infomationImageView)
        containerView.addSubview(baseView)

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
            baseView.frame = self.presented.baseView.frame
            imageView.frame = self.presented.imageView.frame
            infomationImageView.alpha = 1.0
        }) { [weak self] (_) in
            self?.presented.view.alpha = 1.0
            baseView.removeFromSuperview()
            let isComplete = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(isComplete)
        }
    }
}
