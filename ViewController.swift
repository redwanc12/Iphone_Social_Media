//
//  ViewController.swift
//  SampleHttpApp
//
//  Created by Redwan Chowdhury on 3/10/19.
//  Copyright © 2019 Redwan Chowdhury. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let user = TestClient()
    
    
    @IBOutlet weak var usernameTB: UITextField!
    @IBOutlet weak var passwordTB: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //to make the segue pass the user data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    
        if (segue.identifier == "LogInSegue") {
            
            let barViewControllers = segue.destination as! UITabBarController
            let destinationViewController = barViewControllers.viewControllers?[0] as! UploadViewController
            destinationViewController.user = self.user
            
            //access the second tab bar
            let secondDes = barViewControllers.viewControllers?[1] as! ProfileViewController
            secondDes.user = self.user
            
            
        }
    }
        
    @IBAction func testButton(_ sender: Any) {
        
        //authenticates user and logs in
        user.logUserIn(email: usernameTB.text!, password: passwordTB.text!) { (success) in
            if(success){
                self.performSegue(withIdentifier: "LogInSegue", sender: self)
            }
        }
        
    }
}


