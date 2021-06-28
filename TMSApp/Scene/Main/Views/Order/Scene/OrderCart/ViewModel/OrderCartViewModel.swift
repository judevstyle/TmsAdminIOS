//
//  OrderCartViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/30/21.
//

import Foundation
import UIKit
import Combine

protocol OrderCartProtocolInput {
    func setOrderId(orderId: String)
    func fetchOrderCart()
    func confirmOrderCart()
}

protocol OrderCartProtocolOutput: class {
    var didGetOrderCartSuccess: (() -> Void)? { get set }
    var didGetOrderCartError: (() -> Void)? { get set }
    
    func getNumberOfSections(in tableView: UITableView) -> Int
    func getNumberOfOrderCart(_ tableView: UITableView, section: Int) -> Int
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemViewCellHeight() -> CGFloat
    func getHeightSectionView(section: Int) -> CGFloat
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView?
    
    
    func getItem() -> OrderCartData?
}

protocol OrderCartProtocol: OrderCartProtocolInput, OrderCartProtocolOutput {
    var input: OrderCartProtocolInput { get }
    var output: OrderCartProtocolOutput { get }
}

class OrderCartViewModel: OrderCartProtocol, OrderCartProtocolOutput {
    var input: OrderCartProtocolInput { return self }
    var output: OrderCartProtocolOutput { return self }
    
    // MARK: - UseCase
    private var getOrderCartUseCase: GetOrderCartUseCase
    private var confirmOrderCartUseCase: ConfirmOrderCartUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Properties
    private var orderCartViewController: OrderCartViewController
    
    fileprivate var orderId: String?
    fileprivate var itemDetail: OrderCartData?
    fileprivate var listOrderCart: [OrderCartD]? = []

    init(
        orderCartViewController: OrderCartViewController,
        getOrderCartUseCase: GetOrderCartUseCase = GetOrderCartUseCaseImpl(),
        confirmOrderCartUseCase: ConfirmOrderCartUseCase = ConfirmOrderCartUseCaseImpl()
    ) {
        self.orderCartViewController = orderCartViewController
        self.getOrderCartUseCase = getOrderCartUseCase
        self.confirmOrderCartUseCase = confirmOrderCartUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetOrderCartSuccess: (() -> Void)?
    var didGetOrderCartError: (() -> Void)?
    
    func setOrderId(orderId: String) {
        self.orderId = orderId
    }
    
    func fetchOrderCart() {
        self.orderCartViewController.startLoding()
        self.listOrderCart?.removeAll()
        self.itemDetail = nil
        guard let orderId = self.orderId else { return }
        self.getOrderCartUseCase.execute(orderId: orderId).sink { completion in
            debugPrint("getOrderCart \(completion)")
        } receiveValue: { resp in
            if let items = resp?.data {
                self.itemDetail = items
            }
            
            if let items = resp?.data?.orderD {
                self.listOrderCart = items
            }
            
            self.didGetOrderCartSuccess?()
            self.orderCartViewController.stopLoding()
        }.store(in: &self.anyCancellable)
        
    }
    
    func getItem() -> OrderCartData? {
        guard let item = self.itemDetail else { return nil }
        return item
    }
    
    func getNumberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func getNumberOfOrderCart(_ tableView: UITableView, section: Int) -> Int {
        guard let count = listOrderCart?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemOrderCart(index: Int) -> OrderCartD? {
        guard let itemOrder = listOrderCart?[index] else { return nil }
        return itemOrder
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCartTableViewCell.identifier, for: indexPath) as! OrderCartTableViewCell
        cell.selectionStyle = .none
        cell.items = self.listOrderCart?[indexPath.item]
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
    
    func confirmOrderCart() {
        orderCartViewController.showAlertComfirm(titleText: "คุณต้องการยืนยันการสั่งออร์เดอร์ หรือไม่ ?", messageText: "", dismissAction: {
            print("dismissAction")
        }, confirmAction: {
            print("confirmAction")
            self.putconfirmOrderCart()
        })
    }
    
    func putconfirmOrderCart(){
        self.orderCartViewController.startLoding()
        guard let orderId = self.orderId else { return }
        self.confirmOrderCartUseCase.execute(orderId: orderId).sink { completion in
            debugPrint("confirmOrderCart \(completion)")
        } receiveValue: { resp in
            self.orderCartViewController.stopLoding()
            self.orderCartViewController.navigationController?.popViewController(animated: true)
        }.store(in: &self.anyCancellable)
    }
}
