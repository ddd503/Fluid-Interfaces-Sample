//
//  InterfaceType.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/03/04.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

enum InterfaceType: CaseIterable {
    case calculatorButton
    case springAnimations
    case flashlightButton
    case rubberbanding
    case accelerationPausing
    case rewardingMomentum
    case faceTimePiP
    case rotation

    var displayName: String {
        switch self {
        case .calculatorButton:
            return "Calculator Button"
        case .springAnimations:
            return "Spring Animations"
        case .flashlightButton:
            return "Flashlight Button"
        case .rubberbanding:
            return "Rubberbanding"
        case .accelerationPausing:
            return "Acceleration Pausing"
        case .rewardingMomentum:
            return "Rewarding Momentum"
        case .faceTimePiP:
            return "FaceTime PiP"
        case .rotation:
            return "Rotation"
        }
    }

    var imageName: String {
        switch self {
        case .calculatorButton:
            return "icon_calc"
        case .springAnimations:
            return "icon_spring"
        case .flashlightButton:
            return "icon_flash"
        case .rubberbanding:
            return "icon_rubber"
        case .accelerationPausing:
            return "icon_acceleration"
        case .rewardingMomentum:
            return "icon_momentum"
        case .faceTimePiP:
            return "icon_pip"
        case .rotation:
            return "icon_rotation"
        }
    }
}
