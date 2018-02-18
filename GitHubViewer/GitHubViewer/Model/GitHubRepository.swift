//
//  GitHubRepository.swift
//  GitHubViewer
//
//  Created by Guilherme Antunes on 16/02/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation
import Freddy

// Constants
let EmptyLanguageReturnedDefaultText = "Not Specified"

internal struct GitHubRepository {
    
    fileprivate var repoName : String
    fileprivate var language : String
    
    public func getRepoName() -> String {
        return self.repoName
    }
    
    public func getLanguageOfTheRepo() -> String {
        return self.language
    }
    
}

extension GitHubRepository : JSONDecodable {
    public init(json: JSON) throws {
        self.repoName = try json.getString(at: "name")
        self.language = try json.getString(at: "language", alongPath: .nullBecomesNil) ?? EmptyLanguageReturnedDefaultText
    }
}
