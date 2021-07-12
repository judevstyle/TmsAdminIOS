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
    
    
    // ViewModel
    lazy var viewModel: LoginProtocol = {
        let vm = LoginViewModel(loginViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerKeyboardObserver()

        if let AccessToken = UserDefaultsKey.AccessToken.string, AccessToken != "" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                NavigationManager.instance.pushVC(to: .mainTabBar, presentation: .Root, isHiddenNavigationBar: true)
            }
            debugPrint(AccessToken)
        }
    }
    
    @IBAction func handleLogin(_ sender: Any) {
        guard let username = self.inputUsername.text, username != "",
              let password = self.inputPassword.text, password != "" else { return }
        var request: PostAuthEmployeeRequest = PostAuthEmployeeRequest()
        request.username = username
        request.password = password
        viewModel.input.authLogin(request: request)
    }
    
    func configure(_ interface: LoginProtocol) {
        self.viewModel = interface
    }
    
    deinit {
       removeObserver()
    }
}

// MARK: - Binding
extension LoginViewController {
    
    func bindToViewModel() {
        viewModel.output.didLoginSuccess = didLoginSuccess()
        viewModel.output.didLoginError = didLoginError()
    }
    
    func didLoginSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            NavigationManager.instance.pushVC(to: .mainTabBar, presentation: .Root, isHiddenNavigationBar: true)
        }
    }
    
    func didLoginError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
        }
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
        
        //Demo User
        inputUsername.text = "10003"
        inputPassword.text = "0003"
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
