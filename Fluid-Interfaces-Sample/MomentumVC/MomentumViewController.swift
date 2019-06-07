//
//  MomentumViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/03/04.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class MomentumViewController: UIViewController {
    private lazy var cardView: GradientView = {
        let view = GradientView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 1)
        view.topColor = UIColor(hex: 0x61A8FF)
        view.bottomColor = UIColor(hex: 0x243BD1)
        view.frame.size = CGSize(width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.8)
        view.frame.origin.y = self.view.bounds.height * 0.9
        view.center.x = self.view.center.x
        view.cornerRadius = 10
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
        cardView.addSubview(handleView)
        handleView.center.x = view.convert(cardView.frame, to: view).width / 2
        handleView.frame.origin.y = 30
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned(gesture:)))
        cardView.addGestureRecognizer(panGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
        cardView.addGestureRecognizer(tapGesture)
    }

    /// PanGestureに応じてCardViewをアニメーションさせる
    ///
    /// - Parameter shouldMove: cardViewの位置を移動させるかどうか
    private func cardViewAnimation(shouldMove: Bool) {
        guard !animator.isRunning else { return }
        if shouldMove {
            animator =  UIViewPropertyAnimator(duration: 0.1, curve: .easeIn) { [weak self] in
                guard let self = self else { return }
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
                animator = UIViewPropertyAnimator(duration: 0.25, dampingRatio: 0.5) { [weak self] in
                    guard let self = self else { return }
                    self.closedTransform = CGAffineTransform(translationX: 0, y: -(self.cardView.center.y - self.view.center.y) + self.navigationbarHeight)
                    self.cardView.transform = self.closedTransform
                }
            } else {
                animator = UIViewPropertyAnimator(duration: 0.25, dampingRatio: 0.5) { [weak self] in
                    self?.cardView.transform = .identity
                }
            }
        }
        animator.startAnimation()
    }

    /// cardViewのy軸が規定値以上移動したかどうか
    ///
    /// - Returns: true - 移動した, false - 移動していない
    private func isOverLimit() -> Bool {
        if isOpen {
            return -(self.cardView.bounds.height * 0.7) < cardView.transform.ty
        } else {
            return cardView.transform.ty < -(self.cardView.bounds.height * 0.2)
        }
    }

    /// 移動予定方向に規定値以上の速さでスワイプされたかどうか
    ///
    /// - Parameter gesture: スワイプ動作
    /// - Returns: true - された, false - されていない
    private func isFastMoveToY(gesture: UIPanGestureRecognizer) -> Bool {
        let transition = gesture.translation(in: cardView)
        let distanceX = abs(transition.x)
        if isOpen {
            // 下方向 & swipeスピード
            return transition.y > 0 && distanceX < 100 && distanceX > 40 && gesture.velocity(in: view).y > 800
        } else {
            // 上方向 & swipeスピード
            return transition.y < 0 && abs(transition.x) < 100 && gesture.velocity(in: view).y < -800
        }
    }

    @objc private func panned(gesture: UIPanGestureRecognizer) {
        guard !animator.isRunning else { return }
        switch gesture.state {
        case .changed:
            let transition = gesture.translation(in: cardView)
            if isOpen {
                let transform = CGAffineTransform(translationX: 0, y: transition.y)
                cardView.transform = closedTransform.concatenating(transform)
            } else {
                closedTransform = CGAffineTransform(translationX: 0, y: transition.y)
                cardView.transform = closedTransform
            }
        case .ended:
            if isFastMoveToY(gesture: gesture) {
                cardViewAnimation(shouldMove: true)
            } else {
                if isOverLimit() {
                    cardViewAnimation(shouldMove: true)
                } else {
                    cardViewAnimation(shouldMove: false)
                }
            }
        default: break
        }
    }

    @objc private func tapped(gesture: UITapGestureRecognizer) {
        if !isOpen {
            cardViewAnimation(shouldMove: true)
        }
    }
}
