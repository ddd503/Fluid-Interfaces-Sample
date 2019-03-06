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
        view.center = self.view.center
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
        closedTransform = CGAffineTransform(translationX: 0, y: view.bounds.height * 0.8)
        cardView.transform = closedTransform
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned(recognizer:)))
        cardView.addGestureRecognizer(panGesture)
    }

    @objc private func panned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            print("began")
        case .changed:
            print("changed")
        case .ended, .cancelled:
            print("cancelled")
        default: break
        }
    }

}
