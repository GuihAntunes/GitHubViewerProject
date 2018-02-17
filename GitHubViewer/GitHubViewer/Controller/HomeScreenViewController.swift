//
//  HomeScreenViewController.swift
//  GitHubViewer
//
//  Created by Guilherme Antunes on 14/02/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit
import Alamofire
import Freddy

let prefixBaseUrlString = "https://api.github.com/users/"
let suffixBaseUrlString = "/repos"

class HomeScreenViewController: UIViewController {

    // MARK: - Outlets
    
    // MARK: - Properties
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let username = "GuihAntunes"
        let url = URL(string: prefixBaseUrlString + username + suffixBaseUrlString)!
        
        Alamofire.request(url).validate().responseData { (response) in
            guard let data = response.data, let json = try? JSON(data: data) else {
                return
            }
            
            do {
                let user = try json.getArray().map(GitHubRepository.init)
                print(user)
            } catch {
                print("Parsing error!")
            }
        }
        
    }
    
    // MARK: - General Methods
    
    // MARK: - Actions

}
