//
//  PresentViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/19.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class PresentViewController: UIViewController, DestinationTransitionType {
    @IBOutlet var labelView: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func didTapPresent(_ sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
