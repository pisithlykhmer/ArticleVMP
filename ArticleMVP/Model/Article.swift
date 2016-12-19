//
//  Article.swift
//  ArticleMVP
//
//  Created by KSHRD on 12/17/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import Foundation
import ObjectMapper

class Article: Mappable {
    var id: Int?
    var title: String?
    var description: String?
    var image: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["ID"]
        title <- map["TITLE"]
        description <- map["DESCRIPTION"]
        image <- map["IMAGE"]
    }
    
}
