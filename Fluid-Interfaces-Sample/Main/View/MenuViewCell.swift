//
//  MenuViewCell.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/03/03.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class MenuViewCell: UICollectionViewCell {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var interfaceNameLabel: UILabel!

    static var identifier: String {
        return String(describing: self)
    }

}
