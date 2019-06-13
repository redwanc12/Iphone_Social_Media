//
//  MainTabViewController.swift
//  SampleHttpApp
//
//  Created by Redwan Chowdhury on 3/16/19.
//  Copyright © 2019 Redwan Chowdhury. All rights reserved.
//

import UIKit

class MainTabViewController: UIViewController {

    var user = TestClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user.getEmail())
    }

}
