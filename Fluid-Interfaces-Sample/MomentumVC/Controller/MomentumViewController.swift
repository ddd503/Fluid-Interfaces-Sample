//
//  MomentumViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/03/04.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

enum PanGestureType {
    case strongSwipe
    case overLimit
    case lowerLimit
}

final class MomentumViewController: UIViewController {

    private lazy var cardView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.8)
        view.frame.origin.y = self.view.bounds.height * 0.85
        view.center.x = self.view.center.x
        view.backgroundColor = .blue
        return view
    }()

    private lazy var handleView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: self.view.bounds.width * 0.1, height: 5)
        view.center.x = self.view.center.x
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        view.layer.cornerRadius = 3
        return view
    }()

    private var closedTransform = CGAffineTransform()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubView()
    }

    private func layoutSubView() {
        self.view.addSubview(cardView)
        cardView.layer.masksToBounds = true
        cardView.layer.cornerRadius = 10
        cardView.addSubview(handleView)
        handleView.center.x = view.convert(cardView.frame, to: view).width / 2
        handleView.frame.origin.y = 30
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned(gesture:)))
        cardView.addGestureRecognizer(panGesture)
    }

    private func handlePanGesture(gestureType: PanGestureType) {
        var animator: UIViewPropertyAnimator
        switch gestureType {
        case .strongSwipe:
            animator = UIViewPropertyAnimator(duration: 0.1, curve: .easeIn) {
                // 44はナビバー分
                self.cardView.transform = CGAffineTransform(translationX: 0, y: -(self.cardView.center.y - self.view.center.y) + 44)
            }
        case .overLimit:
            animator =  UIViewPropertyAnimator(duration: 0.1, curve: .easeIn) {
                self.cardView.transform = CGAffineTransform(translationX: 0, y: -(self.cardView.center.y - self.view.center.y) + 44)
            }
        case .lowerLimit:
            animator = UIViewPropertyAnimator(duration: 0.35, dampingRatio: 0.5) { [weak self] in
                self?.cardView.transform = .identity
            }
        }
        animator.startAnimation()
    }

    @objc private func panned(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            break
        case .changed:
            let transition = gesture.translation(in: cardView)
            closedTransform = CGAffineTransform(translationX: 0, y: transition.y)
            cardView.transform = closedTransform
        case .ended:
            if gesture.velocity(in: view).y < -400 {
                handlePanGesture(gestureType: .strongSwipe)
            } else {
                if cardView.transform.ty < -(self.cardView.bounds.height * 0.2) {
                    handlePanGesture(gestureType: .overLimit)
                } else {
                    handlePanGesture(gestureType: .lowerLimit)
                }
            }
        default: break
        }
    }

}
