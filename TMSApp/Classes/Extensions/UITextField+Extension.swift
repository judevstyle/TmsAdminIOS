//
//  UITextField+Extension.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 3/26/21.
//


import Foundation
import UIKit

extension UITextField {
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
    
    func setPaddingLeft(padding: CGFloat){
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 5))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    
    func setPaddingRight(padding: CGFloat){
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 5))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setTextFieldBottom() {
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.size.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        self.layer.addSublayer(bottomLine)
    }
    
    func setPaddingLeftAndRight(padding: CGFloat){
        setPaddingLeft(padding: padding)
        setPaddingRight(padding: padding)
    }
    
}
