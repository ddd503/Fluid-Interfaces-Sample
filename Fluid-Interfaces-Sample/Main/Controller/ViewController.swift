//
//  ViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/03/01.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return InterfaceType.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuViewCell.identifier, for: indexPath) as? MenuViewCell else {
            fatalError("failed prepare MenuViewCell")
        }
        cell.setupMenuViewCell(interfaceType: InterfaceType.allCases[indexPath.item])
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let transitionVC = InterfaceType.allCases[indexPath.item].vc else { return }
        self.navigationController?.pushViewController(transitionVC, animated: true)
    }
}
