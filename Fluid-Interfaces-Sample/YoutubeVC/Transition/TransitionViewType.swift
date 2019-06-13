//
//  TransitionViewType.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/06/06.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

protocol SourceTransitionType: UIViewController {
    var baseView: UIView! { get }
    var imageView: UIImageView! { get }
    var label: UILabel! { get }
    var infomationView: UIView! { get }
}

protocol DestinationTransitionType: UIViewController {
    var labelView: UIView! { get }
    var label: UILabel! { get }
    var imageView: UIImageView! { get }
}
