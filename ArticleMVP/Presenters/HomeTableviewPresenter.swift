//
//  HomeTableviewPresenter.swift
//  ArticleMVP
//
//  Created by KSHRD on 12/17/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import Foundation

protocol HomeTableViewPresenterInterface {
    func responseData(data: [Article])
    func DeleteContentSuccess(withMessage message: String)
}

class HomeTableViewPresenter: HomeTableViewPresenterInterface {
    
    
    //  Mark Object
   // Step2 create object of protocol
    var homeTableViewInterface: HomeTableViewInterface?
    var homeTableViewService: HomeTableViewService?
    
    
    func articleLoad(viewInterface: HomeTableViewInterface) {
        
        homeTableViewInterface = viewInterface
        homeTableViewService = HomeTableViewService()
        
        //set Delegate
        homeTableViewService?.homeTableViewPresenterInterface = self
        
    }
    
    func fetchData(page: Int, limit: Int) {
        homeTableViewService?.fetchData(page: page, limit: limit)
    }
    
    func deleteData(id: Int) {
        homeTableViewService?.deleteData(id: id)
    }
    
    // step 6 notify to view
    func responseData(data: [Article]) {
        
        homeTableViewInterface?.articleLoad(article: data)
    }
    
    func DeleteContentSuccess(withMessage message: String) {
        homeTableViewInterface?.DeleteContentSuccess(withMessage: message)
    }
    
    
}
