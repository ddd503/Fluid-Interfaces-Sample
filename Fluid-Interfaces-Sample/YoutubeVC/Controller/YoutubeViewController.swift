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

    class func make() -> YoutubeViewController {
        let vc = UIStoryboard(name: String(describing: self), bundle: .main).instantiateInitialViewController() as! YoutubeViewController
        return vc
    }

    private var subScreenVC: SubScreenViewController!
    private var presentTransitionAnimator: PresentTransitionAnimator?
    private var dismissTransitionAnimator: DismissTransitionAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navigationController = navigationController else { return }
        navigationController.delegate = self
        subScreenVC = SubScreenViewController(image: imageView.image, text: label.text)
        let presentAnimationInteractor = PresentAnimationInteractor(navigationController: navigationController,
                                                                    presenting: self, presented: subScreenVC)
        presentTransitionAnimator = PresentTransitionAnimator(presenting: self, presented: subScreenVC,
                                                              duration: 1.0, presentAnimationInteractor: presentAnimationInteractor)
        let dismissAnimationInteractor = DismissAnimationInteractor(navigationController: navigationController,
                                                                    presented: subScreenVC)
        dismissTransitionAnimator = DismissTransitionAnimator(presenting: self, presented: subScreenVC,
                                                              duration: 1.0, dismissAnimationInteractor: dismissAnimationInteractor)

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
            guard fromVC is SourceTransitionType, toVC is DestinationTransitionType else { return nil }
            return presentTransitionAnimator
        case .pop:
            guard fromVC is DestinationTransitionType else { return nil }
            return dismissTransitionAnimator
        default:
            return nil
        }
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let presentTransitionAnimator = animationController as? PresentTransitionAnimator,
            let presentAnimationInteractor = presentTransitionAnimator.presentAnimationInteractor,
            presentAnimationInteractor.interactionInProgress {
            return presentAnimationInteractor
        } else if let dismissTransitionAnimator = animationController as? DismissTransitionAnimator,
            let dismissAnimationInteractor = dismissTransitionAnimator.dismissAnimationInteractor,
            dismissAnimationInteractor.interactionInProgress {
            return dismissAnimationInteractor
        } else {
            return nil
        }
    }
}
