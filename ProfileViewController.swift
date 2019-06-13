//
//  ProfileViewController.swift
//  SampleHttpApp
//
//  Created by Redwan Chowdhury on 3/14/19.
//  Copyright © 2019 Redwan Chowdhury. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var user = TestClient()
    var imageList = [UIImage]()
    var captionList = [String]()
    
    @IBOutlet weak var nameL: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameL.text = user.getEmail();
    }

    
    @IBAction func refreshB(_ sender: Any) {
        user.getAllPosts { (finished) in
            if(finished){
                let postList = self.user.getProfilePosts();
                for each in postList{
                    self.captionList.append(each.caption)
                    
                    let imageData = try! Data(contentsOf: URL(string: each.imageURL)!)
                    let image = UIImage(data: imageData)
                    self.imageList.append(image!)
                    
                    //print("caption: \(each.caption) \n image: \(each.imageURL) \n")
                }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.user.getProfilePosts().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.image.image = imageList[indexPath.item]
        cell.captionL.text = captionList[indexPath.item]
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    //reloaddata
    
    
}

