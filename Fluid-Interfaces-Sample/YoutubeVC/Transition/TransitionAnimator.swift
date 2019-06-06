//
//  TransitionAnimator.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/06.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit
final class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let isPushTransition: Bool
    weak var presenting: SourceTransitionType?
    weak var presented: DestinationTransitionType?
    let duration: TimeInterval
    let selectedCellIndex: IndexPath

    init(isPushTransition: Bool, presenting: SourceTransitionType, presented: DestinationTransitionType, duration: TimeInterval, selectedCellIndex: IndexPath) {
        self.isPushTransition = isPushTransition
        self.presenting = presenting
        self.presented = presented
        self.duration = duration
        self.selectedCellIndex = selectedCellIndex
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        // TODO: create animation
    }
}
