//
//  MenuViewController.swift
//  GoPlaceCliente
//
//  Created by Henrry Garcia on 18/11/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

enum ProviderType:String{
    case basic
}

class MenuViewController: UIViewController {

    @IBOutlet weak var lblFieldEmail: UILabel!
    
    @IBOutlet weak var lblFieldFullName: UILabel!
    
    @IBOutlet weak var lblFieldProvider: UILabel!
    private let db = Firestore.firestore()
    
    private let email:String
    private let provider:ProviderType
    
    init(email:String, provider:ProviderType){
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lblFieldEmail.text = email
        
        db.collection("users").document(email).getDocument{(documentSnapshot,error) in
            
            if let document = documentSnapshot, error == nil{
                if let name = document.get("name") as? String, let lastName = document.get("lastName") as? String{
                
                    
                self.lblFieldFullName.text = name + " " + lastName
                
                }
            }
            
        }
        
        //lblFieldProvider.text = provider.rawValue

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickBtnCloseSession(_ sender: Any) {
        
        switch provider {
            case .basic:
                do {
                    try Auth.auth().signOut()
                    navigationController?.popViewController(animated: true)
                    //faltaria agregar que vaya a HomeViewController y limpiar cajas de texto
                } catch {
                    //error
                }
            
        }
    }
    
   
    @IBAction func clickBtnLogOut(_ sender: Any) {
        
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        navigationController?.popViewController(animated: true)
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
    }
    
}
