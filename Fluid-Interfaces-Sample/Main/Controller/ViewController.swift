//
//  ViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/03/01.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuViewCell.identifier, for: indexPath) as? MenuViewCell else {
            fatalError("failed prepare MenuViewCell")
        }
        return cell
    }
}
