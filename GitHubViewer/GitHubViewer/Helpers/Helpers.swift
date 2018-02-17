//
//  Helpers.swift
//  GitHubViewer
//
//  Created by Guilherme Antunes on 17/02/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit

let prefixBaseUrlString = "https://api.github.com/users/"
let suffixBaseUrlString = "/repos"
let showActivity = UIActivityIndicatorView()

func getAlertViewControllerWith(title : String, message : String) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    return alertController
}

func startLoading(view : UIView) {
    
    showActivity.center = CGPoint(x: view.center.x, y: view.center.y)
    showActivity.color = UIColor.black
    view.addSubview(showActivity)
    view.bringSubview(toFront: showActivity)
    showActivity.startAnimating()
    
}

func stopLoading() {
    
    showActivity.stopAnimating()
    showActivity.removeFromSuperview()
    
}
