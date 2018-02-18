//
//  HomeScreenViewController.swift
//  GitHubViewer
//
//  Created by Guilherme Antunes on 14/02/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Freddy

// Constants
let reposListSegueIdentifier = "showReposListSegue"
let userFoundString = "User found"
let failedUrlImageString = "Failed to get image url string!"

class HomeScreenViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet fileprivate weak var usernameTextField: UITextField!
    
    // MARK: - Properties
    fileprivate var reposList : [GitHubRepository] = []
    fileprivate var userImage : UIImage = UIImage()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupController()
    }
    
    // MARK: - General Methods
    func setupController() {
        self.usernameTextField.text = ""
        self.becomeFirstResponder()
    }
    
    func fetchReposListForUsername(_ username : String, completion : @escaping (() -> Void)) {
        guard let url = URL(string: prefixBaseUrlString + username + suffixBaseUrlString) else {
            let alert = getAlertViewControllerWith(title: NSLocalizedString(URLErrorTitle, comment: ""), message: NSLocalizedString(URLErrorMessage, comment: ""))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Alamofire.request(url).responseData { (response) in
            stopLoading()
            guard let data = response.data, let json = try? JSON(data: data) else {
                let dataErrorAlert = getAlertViewControllerWith(title: NSLocalizedString(ApiErrorTitle, comment: ""), message: NSLocalizedString(ApiErrorMessage, comment: ""))
                self.present(dataErrorAlert, animated: true, completion: nil)
                return
            }
            
            do {
                let _ = try json.getString(at: "message")
                let dataErrorAlert = getAlertViewControllerWith(title: NSLocalizedString(UserNotFoundErrorTitle, comment: ""), message: NSLocalizedString(UserNotFoundErrorMessage, comment: ""))
                self.present(dataErrorAlert, animated: true, completion: nil)
                return
            } catch {
                print(userFoundString)
            }
            
            do {
                self.reposList = try json.getArray().map(GitHubRepository.init)
            } catch {
                let dataErrorAlert = getAlertViewControllerWith(title: NSLocalizedString(ApiErrorTitle, comment: ""), message: NSLocalizedString(ApiErrorMessage, comment: ""))
                self.present(dataErrorAlert, animated: true, completion: nil)
            }
            
            do {
                let urlStringForImage = try json.getString(at: 0, "owner", "avatar_url", or: "")
                self.fetchUserImage(urlString: urlStringForImage, completion: completion)
            } catch {
                print(failedUrlImageString)
            }
        }
    }
    
    func fetchUserImage(urlString : String, completion : @escaping (() -> Void)) {
        guard let url = URL(string: urlString) else {
            let alert = getAlertViewControllerWith(title: NSLocalizedString(URLErrorTitle, comment: ""), message: NSLocalizedString(URLErrorMessage, comment: ""))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Alamofire.request(url).validate().responseImage { (response) in
            if let image = response.result.value {
                self.userImage = image
            }
            
            completion()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextController = segue.destination as? ReposListViewController, self.usernameTextField.text != nil else {
            return
        }
        nextController.setReposListProperty(reposList: self.reposList)
        nextController.setUsername(username: self.usernameTextField.text ?? "")
        nextController.setUserImage(userImage: self.userImage)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    
    // MARK: - Actions
    @IBAction func search() {
        guard let username = self.usernameTextField.text, !username.isEmpty else {
            let textFieldEmptyAlert = getAlertViewControllerWith(title: NSLocalizedString(EmptyTextFieldTitle, comment: ""), message: NSLocalizedString(EmptyTextFieldMessage, comment: ""))
            self.present(textFieldEmptyAlert, animated: true, completion: nil)
            return
        }
        startLoading(view: self.view)
        self.fetchReposListForUsername(username) {
            self.performSegue(withIdentifier: reposListSegueIdentifier, sender: nil)
        }
        
    }
    
}
