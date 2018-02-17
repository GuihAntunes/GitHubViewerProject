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
    @IBOutlet weak var reposTableView: UITableView!
    
    // MARK: - Properties
    var reposList : [GitHubRepository] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(reposList)
    }
    
    // MARK: - General Methods
    
    // MARK: - Actions

}
