//
//  SubScreenViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/16.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class SubScreenViewController: UIViewController, DestinationTransitionType {
    @IBOutlet var labelView: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    var image: UIImage?
    var text: String?

    init(image: UIImage?, text: String?) {
        self.image = image
        self.text = text
        super.init(nibName: SubScreenViewController.identifier, bundle: .main)
    }

    static var identifier: String {
        return String(describing: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        label.text = text
    }
}
