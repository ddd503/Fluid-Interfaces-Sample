//
//  PushAnimationInteractor.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/16.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class PushAnimationInteractor: UIPercentDrivenInteractiveTransition {
    let navigationController: UINavigationController
    let presenting: SourceTransitionType
    let presented: DestinationTransitionType
    var interactionInProgress = false
    private var shouldCompleteTransition = false

    init(navigationController: UINavigationController, presenting: SourceTransitionType, presented: DestinationTransitionType) {
        self.navigationController = navigationController
        self.presenting = presenting
        self.presented = presented
        super.init()
        setupPanGesture(view: self.presenting.imageView)
    }

    private func setupPanGesture(view : UIView?) {
        guard let view = view else { return }
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleTransitionGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }

    @objc private func handleTransitionGesture(_ gesture : UIPanGestureRecognizer) {
        guard let targetView = presenting.view else { return }
        let viewTranslation = gesture.translation(in: targetView)
        let progress = viewTranslation.y / targetView.frame.height

        switch gesture.state {
        case .began:
            interactionInProgress = true
            navigationController.pushViewController(presented, animated: true)
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
