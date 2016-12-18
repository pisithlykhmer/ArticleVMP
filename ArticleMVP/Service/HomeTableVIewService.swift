//
//  HomeTableVIewService.swift
//  ArticleMVP
//
//  Created by KSHRD on 12/17/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import Foundation
class HomeTableViewService {
    
    //  Mark Instance
    var articles = [Article]()
    var homeTableViewPresenterInterface: HomeTableViewPresenterInterface?
    var editorViewPresenterInterface: EditorViewPresenterInterface?
    
    //  Mark Function Fetch Data
    func fetchData(page: Int, limit: Int) {
        let url = URL(string:  "\(Constant.GlobalConstants.ARTICLE)?page=\(page)&limit=\(limit)")
        var request = URLRequest(url: url!)
        request.setValue("\(Constant.GlobalConstants.headers)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let getTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil {
                
                print(error!)
                
            } else {
                
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                        
                        
                        let jsonData = jsonResult["DATA"] as! [AnyObject]
                        for responseData in jsonData {
                            
                            self.articles.append(Article(JSON: responseData as! [String : Any])!)
                            
                        }
                        
                        //  Notify to presenter
                        self.homeTableViewPresenterInterface?.responseData(data: self.articles)
                        
                    } catch {
                        
                        print("JSON Processing Failed")
                        
                    }
                }
            }
        }
        getTask.resume()
    }
    
    
    //  Mark Function Post Data
    func postData(title: String, description: String, image: String) {
        
        
        let url = URL(string:  "\(Constant.GlobalConstants.ARTICLE)")
        
        
        var request = URLRequest(url: url!)
        request.setValue("\(Constant.GlobalConstants.headers)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dict = ["TITLE": title, "DESCRIPTION": description, "IMAGE": image]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        
        let postTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil {
                
                print(error?.localizedDescription as Any)
                
            } else {
                
                if data != nil {
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(response)")
                        
                    }
                    self.editorViewPresenterInterface?.postContentSuccess(withMessage: "Success")
                    //let responseString = String(data: urlContent, encoding: .utf8)
                    //print("responseString = \(responseString)")
                    
                }
            }
        }
        postTask.resume()
    }
    
    func uploadImage(image: Data) {
        
        var jsonData: String?
        let urlImage = URL(string: "\(Constant.GlobalConstants.UPLOAD_IMAGE)")
        
        var uploadImage = URLRequest(url: urlImage!)
        let boundary = "Boundary-\(UUID().uuidString)"
        
        uploadImage.setValue("\(Constant.GlobalConstants.headers)", forHTTPHeaderField: "Authorization")
        uploadImage.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        uploadImage.httpMethod = "POST"
        uploadImage.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        var formData = Data()
        let mimeType = "image/png" // Multipurpose Internet Mail Extension
        
        // Image
        formData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        formData.append("Content-Disposition: form-data; name=\"FILE\"; filename=\"Image.png\"\r\n".data(using: .utf8)!)
        formData.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        formData.append(image)
        formData.append("\r\n".data(using: .utf8)!)
        formData.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        do {
            uploadImage.httpBody = formData
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        let uploadTask = URLSession.shared.dataTask(with: uploadImage) {
            (data, response, error) in
            
            if error != nil {
                
                print(error as Any)
                
            } else {
                
                if let urlContent = data {
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(response)")
                    }
                    
                    //                    let responseString = String(data: urlContent, encoding: .utf8)
                    //                    print("responseString = \(responseString)")
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                        
                        
                        jsonData = jsonResult["DATA"] as? String
                        
                        
                        //  Notify to presenter
                        self.editorViewPresenterInterface?.responseData(imgUrl: jsonData!)
                        //print(jsonData!)
                        
                    } catch {
                        
                        print("JSON Processing Failed")
                        
                    }
                    
                    
                    
                    
                }
            }
        }
        uploadTask.resume()
    }
    
    
    //  Mark Function Put Data
    func putData(id: Int, title: String, description: String, image: String) {
        
        let url = URL(string: "\(Constant.GlobalConstants.ARTICLE)/\(id)")
        
        
        var request = URLRequest(url: url!)
        request.setValue("\(Constant.GlobalConstants.headers)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dict = ["TITLE": title, "DESCRIPTION": description, "IMAGE": image]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        
        let putTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil {
                
                print(error?.localizedDescription as Any)
                
            } else {
                
                if data != nil {
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(response)")
                        
                    }
                    self.editorViewPresenterInterface?.postContentSuccess(withMessage: "Success")
                    
                }
            }
        }
        putTask.resume()
    }
    
    //  Mark Function Delete Data
    func deleteData(id: Int) {
        
        let url = URL(string: "\(Constant.GlobalConstants.ARTICLE)/\(id)")
        
        
        var request = URLRequest(url: url!)
        request.setValue("\(Constant.GlobalConstants.headers)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let deleteTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil {
                
                print(error?.localizedDescription as Any)
                
            } else {
                
                if data != nil {
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(response)")
                        
                    }
                    self.homeTableViewPresenterInterface?.DeleteContentSuccess(withMessage: "Delete Success")
                    
                }
            }
        }
        deleteTask.resume()
    }
    
}
