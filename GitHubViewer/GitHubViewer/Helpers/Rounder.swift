//
//  Rounder.swift
//  GitHubViewer
//
//  Created by Guilherme Antunes on 17/02/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit

class Rounder: NSObject {
    @IBInspectable var radius:CGFloat     = 10
    @IBInspectable var border:CGFloat    = 1.0
    
    @IBOutlet var targets:[UIView]? {
        
        didSet{
            guard let actualTargets = targets else {
                return
            }
            
            for target in actualTargets {
                target.layer.cornerRadius = radius
                target.layer.borderColor  = UIColor.white.cgColor
                target.layer.borderWidth  = border
                target.clipsToBounds      = true
                
            }
                
        }
            
    }
        
}
