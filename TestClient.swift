//
//  TestClient.swift
//  SampleHttpApp
//
//  Created by Redwan Chowdhury on 3/10/19.
//  Copyright © 2019 Redwan Chowdhury. All rights reserved.
//

import Foundation
import Alamofire

//URL constants
let URL_TO_POST_IMAGE = "http://127.0.0.1:8000/api/timeline/posts/"
let URL_TO_GET_TOKEN = "http://127.0.0.1:8000/api/user/token/"
let URL_TO_GET_POSTS = "http://127.0.0.1:8000/api/timeline/posts/"


//client to interact with API
class TestClient {

    //post struct
    struct Post: Codable {
        var caption: String;
        var imageURL: String;
    }
    
    
    //information about a user
    private var email: String = ""
    private var header: HTTPHeaders = []
    private var profilePosts = [Post]()
    
    
    //access modifier functions
    public func setEmail(email: String){
        self.email = email
    }
    
    public func getEmail() -> String{
        return self.email
    }
    
    public func setHeader(header: HTTPHeaders){
        self.header = header
    }
    
    public func getHeader() -> HTTPHeaders{
        return self.header
    }
    
    public func getProfilePosts() -> [Post]{
        return self.profilePosts
    }
    
    public func appendProfilePost(post: Post){
        profilePosts.append(post)
    }

    
    //function to return all JSON data in a page.
    func getAllData(_ url: String){
        AF.request(url, headers: self.getHeader()).responseJSON { response in
            debugPrint(response);
        }
        
    }
    
    //function to Log a user in
    func post(url: String, data: Parameters, completion: @escaping (Bool) -> ()){
        
        AF.request(url, method: .post, parameters: data, encoding: URLEncoding.default, headers: self.getHeader()).responseJSON { response in
            
            if(response.result.isSuccess){
                completion(true)
            }
            else{
                completion(false)
            }
        }
        
    }
    
    
    //function to get find the header token for the user.
    private func authenticateHeader(email: String, password: String, completion: @escaping (_ result: Bool, _ token: String?) -> ()){
        
        let data: Parameters = [
            "email": email,
            "password": password,
            ]
        
        AF.request(URL_TO_GET_TOKEN, method: .post, parameters: data).responseJSON { response in
            
            if let object = response.result.value as? [String:Any], let tokenValue = object["token"] as? String {
                completion(true, tokenValue)
            }
            else{
                completion(false, nil)
            }
            
        }
        
    }
    
    //function to log user in
    func logUserIn(email: String, password: String, completion: @escaping (Bool) -> ()){
        authenticateHeader(email: email, password: password) { (valid, token) in
            if(valid){
                let header: HTTPHeaders = [
                    "Authorization": "Token \(token!)",
                    "Accept": "application/json"
                ]
                self.setHeader(header: header)
                self.setEmail(email: email)
                completion(true)
            }
            else{
                self.setHeader(header: [])
                completion(false)
            }
        }
    }
    
    //function to make a post
    func createImagePost(image: UIImage, caption: String){
        
        let data: Parameters = [
            "caption": caption,
            ]
        
        AF.upload(multipartFormData: { multipartFormData in
            let imageData = image.jpegData(compressionQuality: 0.5)
            multipartFormData.append(imageData!, withName: "image", fileName: "photo.jpg", mimeType: "jpg/png")
            
            for (key, value) in data {
                if value is String || value is Int {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
            }
        },
                  to: URL_TO_POST_IMAGE,
                  method: .post,
                  headers: self.getHeader()
//                  encodingCompletion: { encodingResult in
//                    switch encodingResult {
//                    case .success(let upload, _, _):
//                        upload.responseJSON { response in
//                            debugPrint(response)
//                        }
//                    case .failure(let encodingError):
//                        print("encoding Error : \(encodingError)")
//                    }
//        }
        )
    }
    
    //function to get images in form of list of paramters?
    func getAllPosts(completion: @escaping (Bool) -> ()){
        
        AF.request(URL_TO_GET_POSTS, headers: self.getHeader()).responseJSON { (response) in

            if let responseArray = response.result.value as? [[String: Any]] {
                
                for each in responseArray{
//                    let caption = each.compactMap { $0["caption"] as? String }
//                    let image = each.compactMap { $0["image"] as? String }
//                    Post newPost:Post = Post
                    self.appendProfilePost(post: Post(caption: each["caption"] as! String, imageURL: each["image"] as! String))

                }
                completion(true)
                
            }
        }
    }
}
        
        
        

