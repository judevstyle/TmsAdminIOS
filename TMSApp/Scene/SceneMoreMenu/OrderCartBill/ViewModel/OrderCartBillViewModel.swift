//
//  OrderCartBillBillViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/5/21.
//

import Foundation
import UIKit
import Combine

protocol OrderCartBillProtocolInput {
    func setOrderId(orderId: Int?)
    func fetchOrderCartBill()
}

protocol OrderCartBillProtocolOutput: class {
    var didGetOrderCartBillSuccess: (() -> Void)? { get set }
    var didGetOrderCartBillError: (() -> Void)? { get set }
    
    func getNumberOfSections(in tableView: UITableView) -> Int
    func getNumberOfOrderCartBill(_ tableView: UITableView, section: Int) -> Int
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemViewCellHeight() -> CGFloat
    func getHeightSectionView(section: Int) -> CGFloat
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView?
    
    func getItem() -> OrderCartData?
}

protocol OrderCartBillProtocol: OrderCartBillProtocolInput, OrderCartBillProtocolOutput {
    var input: OrderCartBillProtocolInput { get }
    var output: OrderCartBillProtocolOutput { get }
}

class OrderCartBillViewModel: OrderCartBillProtocol, OrderCartBillProtocolOutput {
    var input: OrderCartBillProtocolInput { return self }
    var output: OrderCartBillProtocolOutput { return self }
    
    // MARK: - UseCase
    private var getOrderCartBillUseCase: GetOrderCartUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Properties
    private var orderCartBillViewController: OrderCartBillViewController
    
    fileprivate var orderId: Int?
    fileprivate var listOrderCartBill: [OrderCartD]? = []
    fileprivate var itemDetail: OrderCartData?

    init(
        orderCartBillViewController: OrderCartBillViewController,
        getOrderCartBillUseCase: GetOrderCartUseCase = GetOrderCartUseCaseImpl()
    ) {
        self.orderCartBillViewController = orderCartBillViewController
        self.getOrderCartBillUseCase = getOrderCartBillUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetOrderCartBillSuccess: (() -> Void)?
    var didGetOrderCartBillError: (() -> Void)?
    
    func setOrderId(orderId: Int?) {
        self.orderId = orderId
    }
    
    func fetchOrderCartBill() {
        self.orderCartBillViewController.startLoding()
        self.listOrderCartBill?.removeAll()
        guard let orderId = self.orderId else { return }
        self.getOrderCartBillUseCase.execute(orderId: orderId).sink { completion in
            debugPrint("getOrderCartBill \(completion)")
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetOrderCartBill finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "GetOrderCartBill failure")
                break
            }
            
        } receiveValue: { resp in
            
            if let items = resp?.data {
                self.itemDetail = items
            }
            

            if let items = resp?.data?.orderD {
                self.listOrderCartBill = items
            }
            
            self.didGetOrderCartBillSuccess?()
            self.orderCartBillViewController.stopLoding()
        }.store(in: &self.anyCancellable)
        
    }
    
    func getItem() -> OrderCartData? {
        guard let item = self.itemDetail else { return nil }
        return item
    }
    
    func getNumberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func getNumberOfOrderCartBill(_ tableView: UITableView, section: Int) -> Int {
        guard let count = listOrderCartBill?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemOrderCartBill(index: Int) -> OrderCartD? {
        guard let itemOrder = listOrderCartBill?[index] else { return nil }
        return itemOrder
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCartTableViewCell.identifier, for: indexPath) as! OrderCartTableViewCell
        cell.selectionStyle = .none
        cell.items = self.listOrderCartBill?[indexPath.item]
        return cell
    }
    
    func getItemViewCellHeight() -> CGFloat {
        return 123
    }
    
    func getHeightSectionView(section: Int) -> CGFloat {
        return 25
    }
    
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderLabelTableViewCell.identifier)
        if let header = header as? HeaderLabelTableViewCell {
            header.render(title: "รายการสินค้า")
        }
        return header
    }
}
