//
//  YoutubeViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/03/17.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class YoutubeViewController: UIViewController {

    @IBOutlet private weak var baseView: UIView!
    @IBOutlet private weak var infomationView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }

    var interfaceType: InterfaceType?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        title = interfaceType?.displayName
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned(gesture:)))
        imageView.addGestureRecognizer(panGesture)
    }

    @objc private func panned(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            print("changed")
        case .ended:
            print("ended")
        default: break
        }
    }

}

extension YoutubeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "関連項目(\(indexPath.row + 1))"
        return cell
    }
}
