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

        let animationView = UIView(frame: presented.view.frame)
        animationView.backgroundColor = .clear
        let baseView = UIView(frame: presenting.labelView.frame)
        baseView.backgroundColor = .red
        animationView.addSubview(baseView)
        let imageView = UIImageView(image: presenting.imageView.image)
        imageView.frame.origin = presenting.labelView.convert(presenting.imageView.frame.origin, to: presenting.view)
        imageView.frame.size = presenting.imageView.frame.size
        animationView.addSubview(imageView)
        let label = UILabel(frame: presenting.label.frame)
        label.text = presenting.label.text
        label.font = presenting.label.font
        label.textColor = presenting.label.textColor
        animationView.addSubview(label)
        containerView.addSubview(animationView)

        UIView.animate(withDuration: duration, animations: {
            baseView.frame = self.presented.baseView.frame
            baseView.alpha = 0
            imageView.frame = self.presented.imageView.frame
        }) { (_) in
            animationView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}
