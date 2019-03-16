//
//  InterfaceType.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/03/04.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

enum InterfaceType: CaseIterable {
    case rewardingMomentum

    var displayName: String {
        switch self {
        case .rewardingMomentum:
            return "Rewarding Momentum"
        }
    }

    var storyBoardIdentifier: String {
        switch self {
        case .rewardingMomentum:
            return "MomentumViewController"
        }
    }

    var vc: UIViewController? {
        let initialVC = UIStoryboard(name: self.storyBoardIdentifier, bundle: .main).instantiateInitialViewController()
        switch self {
        case .rewardingMomentum:
            let momentumViewController = initialVC as? MomentumViewController
            momentumViewController?.interfaceType = self
            return momentumViewController
        }
    }

    var iconViewColors: (topColor: UIColor, bottomColor: UIColor) {
        switch self {
        case .rewardingMomentum:
            return (UIColor(hex: 0x61A8FF), UIColor(hex: 0x243BD1))
        }
    }
}
