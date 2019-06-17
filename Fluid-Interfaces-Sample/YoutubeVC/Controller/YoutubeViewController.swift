//
//  YoutubeViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/03/17.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class YoutubeViewController: UIViewController, SourceTransitionType {
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infomationView: UIView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }

    var dismissTransitionAnimator: DismissTransitionAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        let gesture = UITapGestureRecognizer(target: self, action: #selector(presentNextVC))
        imageView.addGestureRecognizer(gesture)
    }

    @objc func presentNextVC() {
        let subVC = SubScreenViewController(image: imageView.image, text: label.text)
        navigationController?.pushViewController(subVC, animated: true)
    }

}

extension YoutubeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "関連項目(\(indexPath.row + 1))"
        cell.textLabel?.textColor = .white
        return cell
    }
}

extension YoutubeViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch operation {
        case .push:
            guard let presented = toVC as? DestinationTransitionType else { return nil }
            let presentAnimationInteractor = PresentAnimationInteractor(navigationController: navigationController, presenting: self, presented: presented)

            let dismissAnimationInteractor = DismissAnimationInteractor(navigationController: navigationController,
                                                                        presented: presented)
            dismissTransitionAnimator = DismissTransitionAnimator(presenting: self, presented: presented, duration: 1.0, dismissAnimationInteractor: dismissAnimationInteractor)
            return PresentTransitionAnimator(presenting: self, presented: presented,
                                             duration: 1.0, presentAnimationInteractor: presentAnimationInteractor)
        case .pop:
            return dismissTransitionAnimator
        default:
            return nil
        }
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        if let presentTransitionAnimator = animationController as? PresentTransitionAnimator {
//            return presentTransitionAnimator.presentAnimationInteractor
//        } else if let dismissTransitionAnimator = animationController as? DismissTransitionAnimator {
//            return dismissTransitionAnimator.dismissAnimationInteractor
//        } else {
//            return nil
//        }
        return nil
    }
}
