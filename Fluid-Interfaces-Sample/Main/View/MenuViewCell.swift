//
//  MenuViewCell.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/03/03.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class MenuViewCell: UICollectionViewCell {

    @IBOutlet private weak var iconView: GradientView!
    @IBOutlet private weak var interfaceNameLabel: UILabel!

    static var identifier: String {
        return String(describing: self)
    }

    func setupMenuViewCell(interfaceType: InterfaceType) {
        iconView.topColor = interfaceType.iconViewColors.topColor
        iconView.bottomColor = interfaceType.iconViewColors.bottomColor
        interfaceNameLabel.text = interfaceType.displayName
    }

}
