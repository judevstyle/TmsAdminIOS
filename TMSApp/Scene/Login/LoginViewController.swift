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
        registerKeyboardObserver()
    }
    
    @IBAction func handleLogin(_ sender: Any) {
        NavigationManager.instance.pushVC(to: .mainTabBar, presentation: .Root, isHiddenNavigationBar: true)
    }
    
    deinit {
       removeObserver()
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

extension LoginViewController : KeyboardListener {
    func keyboardDidUpdate(keyboardHeight: CGFloat) {
        viewKeyboardHeight.constant = keyboardHeight
    }
}
