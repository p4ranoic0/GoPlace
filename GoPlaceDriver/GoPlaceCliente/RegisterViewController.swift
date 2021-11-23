//
//  RegisterViewController.swift
//  GoPlaceCliente
//
//  Created by Henrry Garcia on 28/10/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController:UIViewController{
    
    @IBOutlet weak var txtFieldName: TextClassForm!
    
    @IBOutlet weak var txtFieldPassword: TextClassForm!
    
    @IBOutlet weak var txtFieldLastName: TextClassForm!
    
    @IBOutlet weak var txtFieldEmail: TextClassForm!

    @IBOutlet weak var txtFieldPhone: TextClassForm!
    
    @IBOutlet weak var txtFieldLicense: TextClassForm!
        
    @IBOutlet weak var txtFieldDocument: TextClassForm!
    
    private let db = Firestore.firestore()
    
    @IBOutlet weak var constraintBottomScroll: NSLayoutConstraint!
    
    @IBAction func clickBtnClose(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func tapCloseKeyboardRegister(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func swipeCloseKeyboardRegister(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func swipetoOpenKeyboardRegister(_ sender: Any) {
        self.txtFieldName.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerKeyboardEvents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterKeyboardEvents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func clickBtnRegister(_ sender: Any) {
        view.endEditing(true)
        if let email = txtFieldEmail.text, let password = txtFieldPassword.text, let name = txtFieldName.text, let lastName = txtFieldLastName.text, let phone = txtFieldPhone.text,let license = txtFieldLicense.text, let document = txtFieldDocument.text{
            Auth.auth().createUser(withEmail: email, password: password){
                (result, error) in
                
                if let result = result, error == nil{
                    
                    self.saveDataUser(name: name, lastName: lastName, email: email, phone: phone, license: license,document: document )
                    self.showAlertWithTitle("Usuario Nuevo", message: "Se registro el usuario", accept: "Aceptar")
                    
                    self.navigationController?.pushViewController(MenuViewController(email:
                        result.user.email!, provider: .basic), animated: true)
                    
                }else{
                    self.showAlertWithTitle("Error", message: "Se ha producido un error al registrar usuario", accept: "Aceptar")
                }
                    
            }
            
        }
        
    }
    
    private func saveDataUser(name:String,lastName:String, email:String,phone:String,license:String,document:String){
        db.collection("users").document(email).setData([
            "name" : name,
            "lastName" : lastName,
            "email" : email,
            "phone" : phone,
            "state" : 1,
            "type" : "Driver",
            "license" : license,
            "document" : document,
            
            
        ])
        
    }
    
}


extension RegisterViewController{
    
    private func registerKeyboardEvents() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterKeyboardEvents() {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        print("Se abrio el teclado")
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        print(keyboardFrame.height)
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: animationDuration) {
            self.constraintBottomScroll.constant = keyboardFrame.height + 10
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        print("Se cerro el teclado")
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: animationDuration) {
            self.constraintBottomScroll.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}
