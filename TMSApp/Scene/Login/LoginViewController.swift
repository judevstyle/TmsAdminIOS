//
//  LoginViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/14/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var inputUsername: UITextField!
    @IBOutlet var inputLineUsername: UIView!
    @IBOutlet var inputPassword: UITextField!
    @IBOutlet var inputLinePassword: UIView!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var viewKeyboardHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerNotificationCenter()
    }
    
    @IBAction func handleLogin(_ sender: Any) {
        NavigationManager.instance.pushVC(vc: .mainTabBar, presentation: .Root, isHiddenNavigationBar: true)
    }
}

extension LoginViewController {
    func setupUI(){
        
        inputUsername.delegate = self
        inputPassword.delegate = self
        
        viewKeyboardHeight.constant = 0
        hideKeyboardWhenTappedAround()
        inputUsername.setPaddingLeft(padding: 29)
        inputPassword.setPaddingLeft(padding: 29)
        
        btnLogin.setRounded(rounded: 6)
        inputUsername.text = "Nontawatkb"
        inputPassword.text = "123456"
    }
    
    func registerNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
}


//MARK: - EventKeyboardShowHide
extension LoginViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.size.height
            viewKeyboardHeight.constant = keyboardHeight - 50
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        viewKeyboardHeight.constant = 0
    }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case inputUsername:
            inputLineUsername.backgroundColor = UIColor.Primary
            inputLinePassword.backgroundColor = UIColor.PrimaryGray
        case inputPassword:
            inputLinePassword.backgroundColor = UIColor.Primary
            inputLineUsername.backgroundColor = UIColor.PrimaryGray
        default:
            break
        }
    }
}
