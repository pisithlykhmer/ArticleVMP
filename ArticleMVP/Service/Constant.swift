//
//  Constant.swift
//  ArticleMVP
//
//  Created by KSHRD on 12/17/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import Foundation
class Constant {
    struct GlobalConstants {
        // Constant define here.
        static let URL_BASE = "http://120.136.24.174:1301/"
        static let ARTICLE = URL_BASE + "v1/api/articles"
        static let UPLOAD_IMAGE = URL_BASE + "v1/api/uploadfile/single"
        static let headers = "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="
        static let contentType = "application/json; charset=utf-8"
    }
}
