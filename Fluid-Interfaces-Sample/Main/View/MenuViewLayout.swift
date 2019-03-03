//
//  MenuViewLayout.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/03/03.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class MenuViewLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        minimumLineSpacing = 20
        sectionInsetReference = .fromSafeArea
        adjustInsets()
        itemSize = itemSize()
    }

    private func adjustInsets() {
        guard let cv = collectionView else { return }
        cv.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }

    private func itemSize() -> CGSize {
        guard let cv = collectionView else { return CGSize.zero }
        let insets = cv.contentInset
        let itemLength = cv.bounds.width - (insets.left + insets.right)
        return CGSize(width: itemLength, height: 70)
    }

}
