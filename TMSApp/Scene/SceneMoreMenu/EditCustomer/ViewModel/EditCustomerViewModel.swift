//
//  EditCustomerViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 9/1/21.
//

import Foundation
import UIKit
import Combine

protocol EditCustomerProtocolInput {
    func getCustomerType()
}

protocol EditCustomerProtocolOutput: class {
    var didGetCustomerTypeSuccess: (() -> Void)? { get set }
    
    func getListCustomerType() -> [TypeUserData]?
}

protocol EditCustomerProtocol: EditCustomerProtocolInput, EditCustomerProtocolOutput {
    var input: EditCustomerProtocolInput { get }
    var output: EditCustomerProtocolOutput { get }
}

class EditCustomerViewModel: EditCustomerProtocol, EditCustomerProtocolOutput {
    var input: EditCustomerProtocolInput { return self }
    var output: EditCustomerProtocolOutput { return self }
    
    // MARK: - Properties
    private var editCustomerViewController: EditCustomerViewController
    // MARK: - UserCase
    private var getTypeUserUseCase: GetTypeUserUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(
        editCustomerViewController: EditCustomerViewController,
        getTypeUserUseCase: GetTypeUserUseCase = GetTypeUserUseCaseImpl()
    ) {
        self.editCustomerViewController = editCustomerViewController
        self.getTypeUserUseCase = getTypeUserUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetCustomerTypeSuccess: (() -> Void)?
    
    fileprivate var listTypeUser: [TypeUserData]? = []
    
    
    func getCustomerType() {
        listTypeUser?.removeAll()
        editCustomerViewController.startLoding()
        self.getTypeUserUseCase.execute().sink { completion in
            debugPrint("getTypeUserUseCase \(completion)")
            self.editCustomerViewController.stopLoding()
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetProductType finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "GetProductType failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp {
                self.listTypeUser = items
            }
            self.didGetCustomerTypeSuccess?()
        }.store(in: &self.anyCancellable)
    }
    
    func getListCustomerType() -> [TypeUserData]? {
        return self.listTypeUser
    }

}
