//
//  HomeTableViewController.swift
//  ArticleMVP
//
//  Created by KSHRD on 12/17/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import UIKit
import Kingfisher

protocol HomeTableViewInterface {
    func articleLoad(article: [Article])
    func articlePosted()
    func deleteData(id: Int)
    func DeleteContentSuccess(withMessage message:String)
}

class HomeTableViewController: UITableViewController {
    @IBOutlet weak var articleTitleLabel: UILabel!

    @IBOutlet weak var articleImageView: UIImageView!

    @IBOutlet weak var articleDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
}
