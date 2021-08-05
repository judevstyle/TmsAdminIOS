//
//  BillPaymentCollectionViewCellViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/5/21.
//

import Foundation
import UIKit
import Combine

protocol BillPaymentCollectionViewCellProtocolInput {
    func getOrder()
    func setViewController(vc: UIViewController?)
    func setShipmentCustomerItems(item: ShipmentCustomerItems?)
}

protocol BillPaymentCollectionViewCellProtocolOutput: class {
    var didGetOrderSuccess: (() -> Void)? { get set }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getItemOrder(index: Int) -> OrderItems?
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemViewCellHeight() -> CGFloat
}

protocol BillPaymentCollectionViewCellProtocol: BillPaymentCollectionViewCellProtocolInput, BillPaymentCollectionViewCellProtocolOutput {
    var input: BillPaymentCollectionViewCellProtocolInput { get }
    var output: BillPaymentCollectionViewCellProtocolOutput { get }
}

class BillPaymentCollectionViewCellViewModel: BillPaymentCollectionViewCellProtocol, BillPaymentCollectionViewCellProtocolOutput {
    var input: BillPaymentCollectionViewCellProtocolInput { return self }
    var output: BillPaymentCollectionViewCellProtocolOutput { return self }
    
    // MARK: - UseCase
    private var getOrderUseCase: GetOrderUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Properties
    private var vc: UIViewController? = nil
    
    init(
        getOrderUseCase: GetOrderUseCase = GetOrderUseCaseImpl()
    ) {
        self.getOrderUseCase = getOrderUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetOrderSuccess: (() -> Void)?
    
    fileprivate var listOrder: [OrderItems]? = []
    fileprivate var itemsShipmentCustomer: ShipmentCustomerItems?
    
    func getOrder() {
        self.listOrder?.removeAll()
        self.vc?.startLoding()
        var request = GetOrderRequest()
        request.cusId = self.itemsShipmentCustomer?.cusId
        request.status = "F"
        request.page = 1
        request.creditStatus = 2
        self.getOrderUseCase.execute(request: request).sink { completion in

            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetOrder finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "GetOrder failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp?.data?.items {
                self.listOrder = items
            }
            self.didGetOrderSuccess?()
            self.vc?.stopLoding()
        }.store(in: &self.anyCancellable)
    }
    
    func setViewController(vc: UIViewController?) {
        self.vc = vc
    }
    
    func setShipmentCustomerItems(item: ShipmentCustomerItems?) {
        self.itemsShipmentCustomer = item
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        guard let count = listOrder?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemOrder(index: Int) -> OrderItems? {
        guard let itemOrder = listOrder?[index] else { return nil }
        return itemOrder
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BillPaymentTableViewCell.identifier, for: indexPath) as! BillPaymentTableViewCell
        cell.selectionStyle = .none
        cell.itemsBillPayment = listOrder?[indexPath.item]
        return cell
    }
    
    func getItemViewCellHeight() -> CGFloat {
        return 121
    }
}
