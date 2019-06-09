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

        let animationView = UIView(frame: presented.view.bounds)
        animationView.backgroundColor = .clear
        let baseView = UIView(frame: .zero)
        baseView.backgroundColor = .red
        baseView.frame.size = presenting.labelView.frame.size
        baseView.frame.origin = presenting.labelView.frame.origin
        animationView.addSubview(baseView)
        let imageView = UIImageView(image: presenting.imageView.image)
        imageView.frame = presenting.labelView.convert(presenting.imageView.frame, to: presenting.view)
        animationView.addSubview(imageView)
        let label = UILabel(frame: presenting.labelView.convert(presenting.label.frame, to: presenting.view))
        label.text = presenting.label.text
        label.font = presenting.label.font
        label.textColor = presenting.label.textColor
        animationView.addSubview(label)
        containerView.addSubview(animationView)

        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let self = self else {
                transitionContext.cancelInteractiveTransition()
                return
            }
            baseView.frame = self.presented.baseView.frame
            baseView.alpha = 0
            imageView.frame = self.presented.baseView.convert(self.presented.imageView.frame, to: self.presented.view)
            label.frame = self.presented.baseView.convert(self.presented.label.frame, to: self.presented.view)
        }) { [weak self] (_) in
            self?.presented.view.alpha = 1.0
            animationView.removeFromSuperview()
            let isComplete = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(isComplete)
        }
    }
}
