//
//  ReposListViewController.swift
//  GitHubViewer
//
//  Created by Guilherme Antunes on 14/02/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit

class ReposListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet fileprivate weak var reposTableView: UITableView!
    @IBOutlet fileprivate weak var userImageView: UIImageView!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    
    // MARK: - Properties
    fileprivate var reposList : [GitHubRepository] = []
    fileprivate var username : String = String()
    fileprivate var userImage : UIImage = UIImage()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupController()
    }

    // MARK: - General Methods
    public func setReposListProperty(reposList : [GitHubRepository]) {
        self.reposList = reposList
    }
    
    public func setUsername(username : String) {
        self.username = username
    }
    
    public func setUserImage(userImage : UIImage) {
        self.userImage = userImage
    }
    
    fileprivate func setupController() {
        self.reposTableView.dataSource = self
        self.usernameLabel.text = self.username
        self.userImageView.image = self.userImage
    }
    
    // MARK: - Actions

}

extension ReposListViewController : UITableViewDataSource {
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reposList.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.initCellWithModel(model: self.reposList[indexPath.row])
        
        return cell
    }
}
