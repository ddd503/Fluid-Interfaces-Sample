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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
    }

    @IBAction func didTapLabelView(_ sender: UITapGestureRecognizer) {
        guard let youtubeVC = UIStoryboard(name: String(describing: YoutubeViewController.self), bundle: .main).instantiateInitialViewController() as? YoutubeViewController else { return }
        youtubeVC.setInfo(title: title, sourceTransitionType: self)
        navigationController?.pushViewController(youtubeVC, animated: true)
    }
}

extension YoutubeLabelViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch operation {
        case .push:
            guard let presenting = fromVC as? SourceTransitionType, let presented = toVC as? DestinationTransitionType else {
                return nil
            }
            return TransitionAnimator(presenting: presenting, presented: presented, isPresent: true, duration: 1.0)
        case .pop:
            guard let presenting = toVC as? SourceTransitionType, let presented = fromVC as? DestinationTransitionType else {
                return nil
            }
            return TransitionAnimator(presenting: presenting, presented: presented, isPresent: false, duration: 1.0)
        default: return nil
        }
    }
}
