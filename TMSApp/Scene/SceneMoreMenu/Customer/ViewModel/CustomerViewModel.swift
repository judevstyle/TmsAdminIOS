//
//  CustomerViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/4/21.
//

import Foundation
import UIKit
import Combine

protocol CustomerProtocolInput {
    func getCustomer()
}

protocol CustomerProtocolOutput: class {
    var didGetCustomerkSuccess: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol CustomerProtocol: CustomerProtocolInput, CustomerProtocolOutput {
    var input: CustomerProtocolInput { get }
    var output: CustomerProtocolOutput { get }
}

class CustomerViewModel: CustomerProtocol, CustomerProtocolOutput {
    var input: CustomerProtocolInput { return self }
    var output: CustomerProtocolOutput { return self }
    
    // MARK: - Properties
    private var customerViewController: CustomerViewController
    // MARK: - UseCase
    private var getCustomerUseCase: GetCustomerUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    init(
        customerViewController: CustomerViewController,
        getCustomerUseCase: GetCustomerUseCase = GetCustomerUseCaseImpl()
    ) {
        self.customerViewController = customerViewController
        self.getCustomerUseCase = getCustomerUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetCustomerkSuccess: (() -> Void)?
    
    fileprivate var listCustomer: [CustomerItems]? = []
    
    func getCustomer() {
        listCustomer?.removeAll()
        customerViewController.startLoding()
        
        self.getCustomerUseCase.execute().sink { completion in
            debugPrint("getCustomer \(completion)")
            self.customerViewController.stopLoding()
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "getCustomer finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "getCustomer failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp?.items {
                self.listCustomer = items
            }
            self.didGetCustomerkSuccess?()
        }.store(in: &self.anyCancellable)
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 101
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listCustomer?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShopTableViewCell.identifier, for: indexPath) as! ShopTableViewCell
        cell.selectionStyle = .none
        cell.items = self.listCustomer?[indexPath.item]
        return cell
    }
}
