//
//  UploadViewController.swift
//  SampleHttpApp
//
//  Created by Redwan Chowdhury on 3/14/19.
//  Copyright © 2019 Redwan Chowdhury. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {

    //declartions
    var user = TestClient()
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var chooseB: UIButton!
    @IBOutlet weak var captionTB: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func postB(_ sender: Any) {
        
        user.createImagePost(image: mainImage.image!, caption: captionTB.text!)
        
    }
    
    @IBAction func chooseB(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.mainImage.image = image
        }
        
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
