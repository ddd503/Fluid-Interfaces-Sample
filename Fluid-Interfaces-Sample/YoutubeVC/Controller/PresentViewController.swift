//
//  PresentViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/19.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class PresentViewController: UIViewController, SourceTransitionType {
    @IBOutlet var labelView: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!

    private var dismissTransitionAnimator: DismissTransitionAnimator?

    @IBAction func didTapPresent(_ sender: UIButton) {
        let youtubeVC = YoutubeViewController.make()
        navigationController?.pushViewController(youtubeVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
    }
}

extension PresentViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch operation {
        case .push:
            guard fromVC is SourceTransitionType, let toVC =  toVC as? DestinationTransitionType else { return nil }
            let dismissAnimationInteractor = DismissAnimationInteractor(navigationController: navigationController,
                                                                        presented: toVC)
            dismissTransitionAnimator = DismissTransitionAnimator(presenting: self,
                                                                  presented: toVC,
                                                                  duration: 1.0,
                                                                  dismissAnimationInteractor: dismissAnimationInteractor)
            return nil
        case .pop:
            guard fromVC is DestinationTransitionType else { return nil }
            return dismissTransitionAnimator
        default:
            return nil
        }
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let dismissTransitionAnimator = animationController as? DismissTransitionAnimator,
            let dismissAnimationInteractor = dismissTransitionAnimator.dismissAnimationInteractor,
            dismissAnimationInteractor.interactionInProgress {
            return dismissAnimationInteractor
        } else {
            return nil
        }
    }
}
