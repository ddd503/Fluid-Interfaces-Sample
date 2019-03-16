//
//  MomentumViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/03/04.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

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

    private let navigationbarHeight: CGFloat = 44
    private var closedTransform = CGAffineTransform()
    private var isOpen = false
    private var animator = UIViewPropertyAnimator()

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

    private func handlePanGesture(shouldOpen: Bool) {
        guard !animator.isRunning else { return }
        if shouldOpen {
            animator =  UIViewPropertyAnimator(duration: 0.1, curve: .easeIn) {
                if self.isOpen {
                    self.closedTransform = .identity
                    self.cardView.transform = self.closedTransform
                } else {
                    self.closedTransform = CGAffineTransform(translationX: 0, y: -(self.cardView.center.y - self.view.center.y) + self.navigationbarHeight)
                    self.cardView.transform = self.closedTransform
                }
            }
            animator.addCompletion { (position) in
                if position == .end { self.isOpen.toggle() }
            }
        } else {
            if isOpen {
                animator = UIViewPropertyAnimator(duration: 0.35, dampingRatio: 0.5) { [weak self] in
                    guard let self = self else { return }
                    self.closedTransform = CGAffineTransform(translationX: 0, y: -(self.cardView.center.y - self.view.center.y) + self.navigationbarHeight)
                    self.cardView.transform = self.closedTransform
                }
            } else {
                animator = UIViewPropertyAnimator(duration: 0.35, dampingRatio: 0.5) { [weak self] in
                    self?.cardView.transform = .identity
                }
            }
        }
        animator.startAnimation()
    }

    private func isOverLimit() -> Bool {
        if isOpen {
            return -(self.cardView.bounds.height * 0.7) < cardView.transform.ty
        } else {
            return cardView.transform.ty < -(self.cardView.bounds.height * 0.2)
        }
    }

    @objc private func panned(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            break
        case .changed:
            if isOpen {
                let transition = gesture.translation(in: cardView)
                let transform = CGAffineTransform(translationX: 0, y: transition.y)
                cardView.transform.ty = closedTransform.ty + transform.ty
            } else {
                let transition = gesture.translation(in: cardView)
                closedTransform = CGAffineTransform(translationX: 0, y: transition.y)
                cardView.transform = closedTransform
            }
        case .ended:
            if gesture.velocity(in: view).y < -400 {
                handlePanGesture(shouldOpen: true)
            } else {
                if isOverLimit() {
                    handlePanGesture(shouldOpen: true)
                } else {
                    handlePanGesture(shouldOpen: false)
                }
            }
        default: break
        }
    }

}
