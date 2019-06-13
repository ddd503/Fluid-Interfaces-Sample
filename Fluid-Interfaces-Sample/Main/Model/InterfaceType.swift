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
    case youtube

    var displayName: String {
        switch self {
        case .rewardingMomentum:
            return "Rewarding Momentum"
        case .youtube:
            return "Youtube LabelView"
        }
    }

    var storyBoardIdentifier: String {
        switch self {
        case .rewardingMomentum:
            return "MomentumViewController"
        case .youtube:
            return "YoutubeViewController"
        }
    }

    var vc: UIViewController? {
        let initialVC = UIStoryboard(name: self.storyBoardIdentifier, bundle: .main).instantiateInitialViewController()
        switch self {
        case .rewardingMomentum:
            let momentumViewController = initialVC as? MomentumViewController
            momentumViewController?.title = self.displayName
            return momentumViewController
        case .youtube:
            let youtubeLabelViewController = initialVC as? YoutubeViewController
            youtubeLabelViewController?.title = self.displayName
            return youtubeLabelViewController
        }
    }

    var iconViewColors: (topColor: UIColor, bottomColor: UIColor) {
        switch self {
        case .rewardingMomentum:
            return (UIColor(hex: 0x61A8FF), UIColor(hex: 0x243BD1))
        case .youtube:
            return (UIColor(hex: 0xFF9A58), UIColor(hex: 0xFF1E10))
        }
    }
}
