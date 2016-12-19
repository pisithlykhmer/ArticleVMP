//
//  EditorViewController.swift
//  ArticleMVP
//
//  Created by KSHRD on 12/17/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import UIKit

protocol EditorViewInterface {
    func postData(title: String, description: String, image: String)
    func uploadImage(image: Data)
    func returnImageUrl(imgUrl: String)
    func postContentSuccess(withMessage message:String)
    func putData(id: Int, title: String, description: String, image: String)
    
}



// to use imagePick(2 protocol needed)
class EditorViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    @IBOutlet weak var articleTitleTextField: UITextView!
    
    @IBOutlet weak var articleDescriptionTextView: UITextView!
    
    //  Mark Object
    var imagePicker: UIImagePickerController!
    var eventHandler: EditorViewPresenter!
    
    var homeTableViewInterface : HomeTableViewInterface?
    var imageUrl: String!
    var articleToEdit: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //step1
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        eventHandler = EditorViewPresenter()
        
        //set delegate
        eventHandler.editorViewInterface = self
        
        if articleToEdit != nil {
            loadNoteData()
        }
        
        
    }
    
   //step2

    @IBAction func imagePickerButton(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    //step3
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            articleImageView.image = img
        }
        
        
        //print(imageUrl)
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    //step4

    @IBAction func Done(_ sender: Any) {
        let imageData = UIImagePNGRepresentation(articleImageView.image!)
        uploadImage(image: imageData!)
    }
    
    func loadNoteData() {
        // titleNavigation.title = "Edit Note"
        if let article = articleToEdit {
            articleTitleTextField.text = article.title
            articleDescriptionTextView.text = article.description
            
            // load image to imageView Detail
            let imgUrl = article.image
            let url = URL(string: imgUrl!)
            let data = try! Data(contentsOf: url!)
            let image = UIImage(data: data)
            articleImageView.image = image
        }
    }
}

//  Mark conform to EditorViewInterface
extension EditorViewController: EditorViewInterface {
    internal func putData(id: Int, title: String, description: String, image: String) {
        eventHandler.putData(id: id, title: title, description: description, image: image)
    }
    
    
    internal func returnImageUrl(imgUrl: String) {
        
        self.imageUrl = imgUrl
        if articleToEdit == nil {
            postData(title: articleTitleTextField.text!, description: articleDescriptionTextView.text!, image: imageUrl)
        } else {
            putData(id: articleToEdit.id!, title: articleTitleTextField.text!, description: articleDescriptionTextView.text!, image: imgUrl)
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func postData(title: String, description: String, image: String) {
        eventHandler.postData(title: title, description: title, image: image)
    }
    
    func uploadImage(image: Data) {
        eventHandler.uploadImage(image: image)
    }
    
    func postContentSuccess(withMessage message: String) {
        print("Message \(message)")
        
        
    }
    
    
}
