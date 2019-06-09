//
//  YoutubeViewController.swift
//  Fluid-Interfaces-Sample
//
//  Created by kawaharadai on 2019/03/17.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class YoutubeViewController: UIViewController, DestinationTransitionType {
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infomationView: UIView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }

    var image: UIImage?
    var text: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        label.text = text
    }

    func setInfo(title: String?, sourceTransitionType: SourceTransitionType) {
        self.title = title
        self.image = sourceTransitionType.imageView.image
        self.text = sourceTransitionType.label.text
    }
}

extension YoutubeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "関連項目(\(indexPath.row + 1))"
        cell.textLabel?.textColor = .white
        return cell
    }
}
