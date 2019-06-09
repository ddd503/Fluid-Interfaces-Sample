//
//  AnimationInstractor.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/06.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class AnimationInstractor: UIPercentDrivenInteractiveTransition {
    weak var navigationController: UINavigationController!
    weak var presenting: SourceTransitionType?
    weak var presented: DestinationTransitionType?
    let isPushTransition: Bool
    var interactionInProgress = false
    private var shouldCompleteTransition = false

    init(navigationController: UINavigationController, presenting: SourceTransitionType, presented: DestinationTransitionType, isPushTransition: Bool) {
        self.navigationController = navigationController
        self.presenting = presenting
        self.presented = presented
        self.isPushTransition = isPushTransition
        super.init()
        setupTransitionGesture(view: self.presented?.imageView)
    }

    private func setupTransitionGesture(view : UIView?) {
        guard let view = view else { return }
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleTransitionGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }

    @objc private func handleTransitionGesture(_ gesture : UIPanGestureRecognizer) {
        guard let targetView = self.presented?.imageView else { return }
        let viewTranslation = gesture.translation(in: targetView)
        let progress = viewTranslation.x / targetView.frame.width

        switch gesture.state {
        case .began:
            interactionInProgress = true
            navigationController.popViewController(animated: true)
        case .changed:
            // 中心以上スワイプしたら
            shouldCompleteTransition = progress > 0.5
            update(progress)
        case .cancelled:
            interactionInProgress = false
            cancel()
        case .ended:
            interactionInProgress = false
            shouldCompleteTransition ? finish() : cancel()
        default: break
        }
    }
}