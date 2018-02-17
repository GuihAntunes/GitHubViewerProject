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

class HomeScreenViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    
    // MARK: - Properties
    fileprivate var reposList : [GitHubRepository] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - General Methods
    func fetchReposListForUsername(_ username : String, completion : @escaping (() -> Void)) {
        guard let url = URL(string: prefixBaseUrlString + username + suffixBaseUrlString) else {
            let alert = getAlertViewControllerWith(title: "Error", message: "Failed to get URL! Try again later or contact us for support!")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Alamofire.request(url).validate().responseData { (response) in
            stopLoading()
            guard let data = response.data, let json = try? JSON(data: data) else {
                let dataErrorAlert = getAlertViewControllerWith(title: "A network error has occured", message: "Check your Internet connection and try again later")
                self.present(dataErrorAlert, animated: true, completion: nil)
                return
            }
            
            do {
                self.reposList = try json.getArray().map(GitHubRepository.init)
                completion()
            } catch {
                let dataErrorAlert = getAlertViewControllerWith(title: "A network error has occured", message: "Check your Internet connection and try again later")
                self.present(dataErrorAlert, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextController = segue.destination as? ReposListViewController else {
            return
        }
        nextController.reposList = self.reposList
    }
    
    // MARK: - Actions
    @IBAction func search() {
        guard let username = self.usernameTextField.text, !username.isEmpty else {
            let textFieldEmptyAlert = getAlertViewControllerWith(title: "No username entered!", message: "Insert a username to proceed!")
            self.present(textFieldEmptyAlert, animated: true, completion: nil)
            return
        }
        startLoading(view: self.view)
        self.fetchReposListForUsername(username) {
            self.performSegue(withIdentifier: "showReposListSegue", sender: nil)
        }
        
    }
    
}
