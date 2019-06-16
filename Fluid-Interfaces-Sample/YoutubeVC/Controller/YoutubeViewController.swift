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

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navigationController = navigationController else { return }
        navigationController.delegate = self

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(taped(_:)))
        imageView.addGestureRecognizer(tapGesture)

    }

    @objc func taped(_ sender: UITapGestureRecognizer) {
        let vc = YoutubeLabelViewController.make(image: imageView.image, text: label.text)
        navigationController?.pushViewController(vc, animated: true)
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
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        guard let transitionAnimator = animationController as? TransitionAnimator else {
            return nil
        }

        if transitionAnimator.isPresent,
            let pushAnimationInteractor = transitionAnimator.pushAnimationInteractor,
            pushAnimationInteractor.interactionInProgress {
            return pushAnimationInteractor
        } else if let popAnimationInteractor = transitionAnimator.popAnimationInteractor,
            popAnimationInteractor.interactionInProgress {
            return popAnimationInteractor
        } else {
            return nil
        }
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch operation {
        case .push:
            guard let presented = toVC as? DestinationTransitionType else { return nil }
            return TransitionAnimator(presenting: self, presented: presented, isPresent: true, duration: 1.0, interactiveTransition: PushAnimationInteractor(navigationController: navigationController, presenting: self, presented: presented))
        case .pop:
            guard let presented = fromVC as? DestinationTransitionType else { return nil }
            return TransitionAnimator(presenting: self, presented: presented, isPresent: false, duration: 1.0, interactiveTransition: PopAnimationInteractor(navigationController: navigationController, presented: presented))
        default: return nil
        }
    }
}
