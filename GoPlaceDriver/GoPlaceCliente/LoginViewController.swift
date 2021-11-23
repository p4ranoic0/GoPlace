//
//  LoginViewController.swift
//  GoPlaceCliente
//
//  Created by Henrry Garcia on 10/10/21.
//

import UIKit
import FirebaseAuth
class LoginViewController : UIViewController{
  
    
    @IBOutlet weak var txtFieldEmail: TextClassForm!    
    @IBOutlet weak var txtFieldPassword: TextClassForm!

    
    @IBAction func clickBtnClose(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
 
    @IBAction func tapCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func swipetoOpenKeyboardRegister(_ sender: Any) {
        self.txtFieldEmail.becomeFirstResponder()
    }
    
    @IBAction func swipeCloseKeyboardLogin(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerKeyboardEvents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterKeyboardEvents()
    }
      
    @IBAction func clickBtnLogin(_ sender: Any) {
        
        if let email = txtFieldEmail.text, let password = txtFieldPassword.text{
            Auth.auth().signIn(withEmail: email, password: password){
                (result, error) in
                
                if let result = result, error == nil{
                    self.navigationController?.pushViewController(MenuViewController(email:
                        result.user.email!, provider: .basic), animated: true)
                }else{
                    self.showAlertWithTitle("Error Login", message: "Los datos son incorrectos", accept: "Aceptar")
                }
                    
            }
            
        }
        
    }
    
    
}

extension LoginViewController{
    
    private func registerKeyboardEvents() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func unregisterKeyboardEvents() {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        print("Se abrio el teclado")
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        print("Se cerro el teclado")
    }
}
    
