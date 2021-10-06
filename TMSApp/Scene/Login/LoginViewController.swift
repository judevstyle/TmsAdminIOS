//
//  LoginViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/14/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var topView: UIView!
    @IBOutlet var inputUsername: UITextField!
    @IBOutlet var inputPassword: UITextField!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var bottomView: UIView!
    
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
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
            NavigationManager.instance.setRootViewController(rootView: .mainTabBar, withNav: false, isTranslucent: true)
        }
    }
    
    func didLoginError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
        }
    }
}

extension LoginViewController {
    func setupUI() {
        topView.roundCorners(corners: .bottomLeft, radius: 20)
        
        bottomView.roundedTop(radius: 20)
        
        btnLogin.setRounded(rounded: 8)
        inputUsername.setRounded(rounded: 8)
        inputPassword.setRounded(rounded: 8)
        
        inputUsername.setBorder(width: 1.0, color: UIColor.Primary)
        inputPassword.setBorder(width: 1.0, color: UIColor.Primary)
        
        btnLogin.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        inputUsername.text = "asdasd"
        inputPassword.text = "123456"
        inputPassword.isSecureTextEntry = true
    }
}

extension LoginViewController {
    @objc func handleLogin() {
        guard let username = self.inputUsername.text, username != "",
              let password = self.inputPassword.text, password != "" else { return }
        var request: PostAuthEmployeeRequest = PostAuthEmployeeRequest()
        request.username = username
        request.password = password
        viewModel.input.authLogin(request: request)
    }
}

extension LoginViewController : KeyboardListener {
    func keyboardDidUpdate(keyboardHeight: CGFloat) {
        bottomConstraint.constant = keyboardHeight
    }
}
