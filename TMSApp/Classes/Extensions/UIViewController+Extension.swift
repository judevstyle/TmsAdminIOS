//
//  UIViewController+Extension.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 3/26/21.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

extension UIViewController {
    
    func errorDialog(title: String, message: String) {
        let dialogMessage = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default,  handler: { (action) -> Void in
            
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}

extension UIViewController: NVActivityIndicatorViewable {
    
    func startLoding() {
//        let size = CGSize(width: 70.0, height: 70.0)
//        startAnimating(size, message: "", type: .ballScaleMultiple,color: .whiteAlpha(alpha: 0.7), backgroundColor: .blackAlpha(alpha: 0.1), textColor: .white, fadeInAnimation: nil)
        let size = CGSize(width: 35.0, height: 35.0)
        startAnimating(size, message: "", type: .circleStrokeSpin, color: UIColor.Primary, backgroundColor: .blackAlpha(alpha: 0.1), textColor: .white, fadeInAnimation: nil)
    }
    
    func stopLoding() {
        stopAnimating()
    }
    
    
    func startLodingCircle() {
        let size = CGSize(width: 35.0, height: 35.0)
        startAnimating(size, message: "", type: .circleStrokeSpin,color: .whiteAlpha(alpha: 0.7), backgroundColor: .blackAlpha(alpha: 0.3), textColor: .white, fadeInAnimation: nil)
    }
}
