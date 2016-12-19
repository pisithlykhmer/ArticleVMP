//
//  HomeTableViewCell.swift
//  ArticleMVP
//
//  Created by KSHRD on 12/18/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    
    
    @IBOutlet weak var articleImageView: UIImageView!
    func customCell(article: Article) {
        imageView?.layer.cornerRadius = 3
        
        
        articleTitleLabel.text = article.title?.capitalized
        articleDescriptionLabel.text = article.description
        imageView?.kf.setImage(with: URL(string: (article.image?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!))
        
        
        
        
    }
    
    
}

