//
//  HomeTableViewController.swift
//  ArticleMVP
//
//  Created by KSHRD on 12/17/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

//import UIKit
//import Kingfisher
//
//protocol HomeTableViewInterface {
//    func articleLoad(article: [Article])
//    func articlePosted()
//    func deleteData(id: Int)
//    func DeleteContentSuccess(withMessage message:String)
//}
//
//class HomeTableViewController: UITableViewController {
//
//    
//    //  Mark Object
//    var eventHandler: HomeTableViewPresenter!
//    var articles = [Article]()
//    var editorViewInterface: EditorViewInterface!
//    var editor : EditorViewController?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//             
//
//    }
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }
//}

import UIKit
import Kingfisher

protocol HomeTableViewInterface {
    func articleLoad(article: [Article])
    func articlePosted()
    func deleteData(id: Int)
    func DeleteContentSuccess(withMessage message:String)
}

class HomeTableViewController: UITableViewController {
    
    //  Mark Object
    var eventHandler: HomeTableViewPresenter!
    var articles = [Article]()
    var editorViewInterface: EditorViewInterface!
    var editor : EditorViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //step3 create presenter object
        eventHandler = HomeTableViewPresenter()
        
        
        //step5 set delegate
        eventHandler.articleLoad(viewInterface: self)
        
        
        eventHandler.fetchData(page: 1, limit: 15)
    }
    
    @IBAction func AddArticleButton(_ sender: Any) {
        performSegue(withIdentifier: "seguePostAndPut", sender: self)
    }
   }
////  Mark HomeTableViewInterface
//Step1 conform protocol
extension HomeTableViewController: HomeTableViewInterface {
    internal func DeleteContentSuccess(withMessage message: String) {
        print(message)
    }
    
    internal func deleteData(id: Int) {
        eventHandler.deleteData(id: id)
    }
    
    
    internal func articlePosted() {
        self.tableView.reloadData()
    }
    
    // final step
    func articleLoad(article: [Article]) {
        if article.count > 0 {
            self.articles = article
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}


//  Mark UITableViewControllerDataSource
extension HomeTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableCell", for: indexPath) as! HomeTableViewCell
        
        // CustomCell
        cell.customCell(article: articles[indexPath.row])
        
       // print("articles.count \(articles.count)")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121
    }
    
}

//  Mark Segue
extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // customize row swapping to show more button
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        func edit() {
            let article = articles[indexPath.row]
            performSegue(withIdentifier: "seguePostAndPut", sender: article)
        }
        
        func delete() {
            var articleToDelete: Article!
            articleToDelete = articles[indexPath.row]
            if let article = articleToDelete {
                
                deleteData(id: article.id!)
                tableView.reloadData()
                print("IDDD: ", article.id!)
            }
        }
        
        let moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Edit", handler:{action, indexpath in
            edit()
        });
        moreRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete", handler:{action, indexpath in
            delete()
        });
        
        return [deleteRowAction, moreRowAction];
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguePostAndPut" {
            if let destination = segue.destination as? EditorViewController {
                if let article = sender as? Article {
                    destination.articleToEdit = article
                }
                
            }
        }
    }
}

