//
//  YoutubeLabelViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/06.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class YoutubeLabelViewController: UIViewController {

    var interfaceType: InterfaceType?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = interfaceType?.displayName
    }

}
