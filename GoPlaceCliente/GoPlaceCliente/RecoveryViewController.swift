//
//  RecoveryViewController.swift
//  GoPlaceCliente
//
//  Created by Henrry Garcia on 18/11/21.
//

import UIKit
import FirebaseAuth

class RecoveryViewController:UIViewController{
    @IBOutlet weak var txtEmailLogin: UITextField!
    
    @IBAction func clickBtnClose(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    @IBAction func tapCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func swipetoOpenKeyboardRegister(_ sender: Any) {
        self.txtEmailLogin.becomeFirstResponder()
    }
    
    @IBAction func swipeCloseKeyboardLogin(_ sender: Any) {
        self.view.endEditing(true)
    }
     
    @IBAction func clickBtnRecoveryEmail(_ sender: Any) {
        if let email:String = txtEmailLogin.text{
        Auth.auth().sendPasswordReset(withEmail: email) {
           error in
        if error != nil {
           self.showAlertWithTitle("Restablecimiento", message: "Se enviado un correo de restablecimiento", accept: "Aceptar")
        }else{
            
            self.showAlertWithTitle("Email desconocido", message: "El email no se encuentra registrado", accept: "Aceptar")
        }
    }
    }
    }
}
