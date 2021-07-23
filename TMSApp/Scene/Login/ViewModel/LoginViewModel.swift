//
//  LoginViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/7/21.
//

import Foundation
import UIKit
import Combine

protocol LoginProtocolInput {
    func authLogin(request: PostAuthEmployeeRequest)
}

protocol LoginProtocolOutput: class {
    var didLoginSuccess: (() -> Void)? { get set }
    var didLoginError: (() -> Void)? { get set }
}

protocol LoginProtocol: LoginProtocolInput, LoginProtocolOutput {
    var input: LoginProtocolInput { get }
    var output: LoginProtocolOutput { get }
}

class LoginViewModel: LoginProtocol, LoginProtocolOutput {
    var input: LoginProtocolInput { return self }
    var output: LoginProtocolOutput { return self }
    
    // MARK: - Properties
    private var postAuthEmployeeUseCase: PostAuthEmployeeUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    private var loginViewController: LoginViewController
    
    init(
        loginViewController: LoginViewController,
        postAuthEmployeeUseCase: PostAuthEmployeeUseCase = PostAuthEmployeeUseCaseImpl()
    ) {
        self.loginViewController = loginViewController
        self.postAuthEmployeeUseCase = postAuthEmployeeUseCase
    }
    
    // MARK - Data-binding OutPut
    var didLoginSuccess: (() -> Void)?
    var didLoginError: (() -> Void)?
    
    func authLogin(request: PostAuthEmployeeRequest) {
        loginViewController.startLoding()
        self.postAuthEmployeeUseCase.execute(request: request).sink { completion in
            debugPrint("postAuthEmployee \(completion)")
            self.loginViewController.stopLoding()
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "Login finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "Login failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp, items.success {
                if let accessToken = items.data?.accessToken, let expireAccessToken = items.data?.expire {
                    debugPrint(accessToken)
                    UserDefaultsKey.AccessToken.set(value: accessToken)
                    UserDefaultsKey.ExpireAccessToken.set(value: expireAccessToken)
                    self.didLoginSuccess?()
                }
            }
        }.store(in: &self.anyCancellable)
    }
    
}
