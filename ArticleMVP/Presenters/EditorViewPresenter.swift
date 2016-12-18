//
//  EditorViewPresenter.swift
//  ArticleMVP
//
//  Created by KSHRD on 12/17/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import Foundation

protocol EditorViewPresenterInterface {
    func responseData(imgUrl: String)
    func postContentSuccess(withMessage message: String)
}

class EditorViewPresenter {
    
    //  Mark Object
    var editorViewInterface: EditorViewInterface?
    var homeTableViewService = HomeTableViewService()
    
    func postData(title: String, description: String, image: String) {
        homeTableViewService.postData(title: title, description: description, image: image)
    }
    
    func putData(id: Int, title: String, description: String, image: String) {
        homeTableViewService.putData(id: id, title: title, description: description, image: image)
    }
    
    func uploadImage(image: Data){
        homeTableViewService.editorViewPresenterInterface = self
        homeTableViewService.uploadImage(image: image)
    }
}

extension EditorViewPresenter: EditorViewPresenterInterface {
    internal func responseData(imgUrl: String) {
        editorViewInterface?.returnImageUrl(imgUrl: imgUrl)
    }
    
    func postContentSuccess(withMessage message: String) {
        editorViewInterface?.postContentSuccess(withMessage: message)
    }
    
    
}

