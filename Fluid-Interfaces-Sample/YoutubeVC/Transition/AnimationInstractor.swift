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
    // memory leak 防止する
    var presented: DestinationTransitionType?
    let isPresent: Bool
    var interactionInProgress = false
    private var shouldCompleteTransition = false

    init(navigationController: UINavigationController, presentingVC: UIViewController, presentedVC: UIViewController, isPresent: Bool) {
        self.navigationController = navigationController
        self.presenting = presentingVC as? SourceTransitionType
        self.presented = (presentedVC as! DestinationTransitionType)
        self.isPresent = isPresent
        super.init()
        
        if self.isPresent {
            setupPanGesture(view: self.presenting?.imageView)
        } else {
            setupPanGesture(view: self.presented?.labelView)
        }
    }

    private func setupPanGesture(view : UIView?) {
        guard let view = view else { return }
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleTransitionGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }

    @objc private func handleTransitionGesture(_ gesture : UIPanGestureRecognizer) {
        guard let targetView = isPresent ? presenting?.view : presented?.view else { return }
        let viewTranslation = gesture.translation(in: targetView)
        let progress = viewTranslation.y / targetView.frame.height

        switch gesture.state {
        case .began:
            interactionInProgress = true
            if isPresent, let presented = presented {
                navigationController.pushViewController(presented, animated: true)
            } else {
                navigationController.popViewController(animated: true)
            }
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
