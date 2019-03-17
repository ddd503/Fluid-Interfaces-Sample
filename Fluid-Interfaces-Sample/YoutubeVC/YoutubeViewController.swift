//
//  YoutubeViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/03/17.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class YoutubeViewController: UIViewController {

    @IBOutlet private weak var baseView: UIView!
    @IBOutlet private weak var infomationView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }

    var interfaceType: InterfaceType?
    private var animator = UIViewPropertyAnimator()
    private var isTransform = false
    private var baseViewTranslationTransform = CGAffineTransform.identity
    private var imageViewTranslationTransform = CGAffineTransform.identity
    private var imageViewScaleTransform = CGAffineTransform.identity

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        title = interfaceType?.displayName

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned(gesture:)))
        imageView.addGestureRecognizer(panGesture)
    }

    private func transformSubViews(shouldTransform: Bool) {
        if shouldTransform {
            animator =  UIViewPropertyAnimator(duration: 0.1, curve: .easeIn) { [weak self] in
                guard let self = self else { return }
                if self.isTransform {
                    self.baseViewTranslationTransform = CGAffineTransform(translationX: 0, y: 0)
                    self.baseView.transform = self.baseViewTranslationTransform
                } else {
                    self.baseViewTranslationTransform = CGAffineTransform(translationX: 0, y: self.baseView.bounds.size.height * 0.85)
                    self.baseView.transform = self.baseViewTranslationTransform
                }
            }
            animator.addCompletion { (position) in
                if position == .end { self.isTransform.toggle() }
            }
        } else {}
        animator.startAnimation()
    }

    @objc private func panned(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let transition = gesture.translation(in: imageView)
            if isTransform {
                let translationTransform = CGAffineTransform(translationX: 0, y: transition.y)
                baseView.transform.ty = baseViewTranslationTransform.ty + translationTransform.ty
            } else {
                baseViewTranslationTransform = CGAffineTransform(translationX: 0, y: transition.y)
                baseView.transform = baseViewTranslationTransform
            }
//            let diffarence = baseView.bounds.size.height / (baseView.bounds.size.height + transition.y)
//            baseViewTranslationTransform = CGAffineTransform(translationX: 0, y: transition.y)
//            baseView.transform = baseViewTranslationTransform
        case .ended:
            transformSubViews(shouldTransform: true)
        default: break
        }
    }

}

extension YoutubeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "関連項目(\(indexPath.row + 1))"
        return cell
    }
}
