//
//  RepositoryTableViewCell.swift
//  GitHubViewer
//
//  Created by Guilherme Antunes on 17/02/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var repositoryName: UILabel!
    @IBOutlet fileprivate weak var repositoryLanguage: UILabel!
    
    public func initCellWithModel(model : GitHubRepository) {
        self.repositoryName.text = model.getRepoName()
        self.repositoryLanguage.text = model.getLanguageOfTheRepo()
    }
}
