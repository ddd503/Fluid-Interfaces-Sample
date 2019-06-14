//
//  YoutubeLabelViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/06.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class YoutubeLabelViewController: UIViewController, DestinationTransitionType {
    @IBOutlet var labelView: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    var image: UIImage?
    var text: String?

    class func make(image: UIImage?, text: String?) -> YoutubeLabelViewController {
        let youtubeLabelVC = UIStoryboard(name: String(describing: YoutubeLabelViewController.self), bundle: .main).instantiateInitialViewController() as! YoutubeLabelViewController
        youtubeLabelVC.image = image
        youtubeLabelVC.text = text
        return youtubeLabelVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        label.text = text
    }

}
