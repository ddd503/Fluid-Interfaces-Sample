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
        view.frame.size = CGSize(width: self.view.bounds.width * 0.8, height: self.view.bounds.height * 0.8)
        view.center = self.view.center
        view.backgroundColor = .blue
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(cardView)
    }

}
