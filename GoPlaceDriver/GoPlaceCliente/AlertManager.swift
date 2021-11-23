//
//  AlertManager.swift
//  GoPlaceCliente
//
//  Created by Henrry Garcia on 12/10/21.
//

import UIKit

extension UIViewController {
    
    func showAlertWithTitle(_ title: String, message: String, accept: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: accept, style: .cancel, handler: nil)
        alertController.addAction(closeAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
