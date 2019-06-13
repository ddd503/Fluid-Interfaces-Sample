//
//  YoutubeLabelViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/06.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class YoutubeLabelViewController: UIViewController, SourceTransitionType {
    @IBOutlet var labelView: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    var image: UIImage?
    var text: String?

    class func make(image: UIImage, text: String) -> YoutubeLabelViewController {
        let youtubeLabelVC = UIStoryboard(name: String(describing: YoutubeLabelViewController.self), bundle: .main).instantiateInitialViewController() as! YoutubeLabelViewController
        youtubeLabelVC.image = image
        youtubeLabelVC.text = text
        return youtubeLabelVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        imageView.image = image
        label.text = label.text
    }

}

extension YoutubeLabelViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let transitionAnimator = animationController as? TransitionAnimator else { return nil }
        return transitionAnimator.animationInstractor
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch operation {
        case .push:
            guard let presenting = fromVC as? SourceTransitionType,
                let presented = toVC as? DestinationTransitionType else { return nil }

            let animationInstractor = AnimationInstractor(navigationController: navigationController,
                                                          presenting: presenting, presented: presented, isPresent: true)

            return TransitionAnimator(presenting: presenting, presented: presented, isPresent: true,
                                      duration: 1.0, animationInstractor: animationInstractor)
        case .pop:
            guard let presenting = toVC as? SourceTransitionType,
                let presented = fromVC as? DestinationTransitionType else { return nil }

            let animationInstractor = AnimationInstractor(navigationController: navigationController,
                                                          presenting: presenting, presented: presented, isPresent: false)

            return TransitionAnimator(presenting: presenting, presented: presented, isPresent: false,
                                      duration: 1.0, animationInstractor: animationInstractor)
        default: return nil
        }
    }
}
