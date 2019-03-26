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
    private var infomationViewTranslationTransform = CGAffineTransform.identity

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
//            animator =  UIViewPropertyAnimator(duration: 0.1, curve: .easeIn) { [weak self] in
//                guard let self = self else { return }
//                if self.isTransform {
//                    self.baseViewTranslationTransform = CGAffineTransform(translationX: 0, y: 0)
//                } else {
//                    self.imageViewScaleTransform = CGAffineTransform(scaleX: 0.4, y: 0.45)
//                    self.imageViewTranslationTransform = CGAffineTransform(translationX: -120, y: -60)
////                    self.baseViewTranslationTransform = CGAffineTransform(translationX: 0, y: self.baseView.bounds.size.height * 0.85)
//                }
//                self.imageView.transform = self.imageViewScaleTransform.concatenating(self.imageViewTranslationTransform)
//                self.baseView.transform = self.baseViewTranslationTransform
//            }
//            animator.addCompletion { (position) in
//                if position == .end { self.isTransform.toggle() }
//            }
        } else {
            // 動作のキャンセル
        }
        animator.startAnimation()
    }

    @objc private func panned(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let transition = isTransform ? gesture.translation(in: baseView) : gesture.translation(in: imageView)
            if isTransform {
                // すでに変形ずみの場合
            } else {
                baseViewTranslationTransform = CGAffineTransform(translationX: 0, y: transition.y)
                let diffarence = imageView.bounds.size.height / (imageView.bounds.size.height + transition.y * 0.1)
                imageViewScaleTransform = CGAffineTransform(scaleX: 1.0, y: diffarence)
                imageViewTranslationTransform = CGAffineTransform(translationX: 0, y: transition.y)
                imageView.transform = imageViewScaleTransform.concatenating(imageViewTranslationTransform)
                infomationViewTranslationTransform = CGAffineTransform(translationX: 0, y: transition.y * 0.9)
                infomationView.transform = infomationViewTranslationTransform
                infomationView.alpha = 1.0 - (transition.y / 200)
            }
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
