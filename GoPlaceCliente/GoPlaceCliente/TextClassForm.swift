//
//  TextClassForm.swift
//  GoPlaceCliente
//
//  Created by Henrry Garcia on 6/11/21.
//

import UIKit

@IBDesignable class TextClassForm : UITextField{
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        
        self.borderStyle = .none
        self.frame.size.height = 45
        
        self.layer.cornerRadius  = 1
        self.layer.borderColor = UIColor(0, 109.0,119.0, 1.0).cgColor
        self.layer.borderWidth = 2
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.01, height: 1.9)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        
     
        
        self.backgroundColor = .white

    }
}

extension UIColor {
    convenience init(_ r: Double,_ g: Double,_ b: Double,_ a: Double) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
