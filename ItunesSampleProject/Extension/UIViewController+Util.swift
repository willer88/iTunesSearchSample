//
//  UIViewController+Util.swift
//
//  Created by Wilmar on 1/12/20.
//  Copyright © 2020 Wilmar Lema. All rights reserved.
//

import UIKit
import AVFoundation

extension UIViewController {
    
    func showErrorMessage(message: String, completion: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completion.map { $0() }
        }))
        present(alertController, animated: true, completion: nil)
    }
}
