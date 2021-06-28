//
//  OrderViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/16/21.
//

import Foundation
import UIKit
import Combine

protocol OrderProtocolInput {
    func getOrder()
}

protocol OrderProtocolOutput: class {
    var didGetOrderSuccess: (() -> Void)? { get set }
    var didGetOrderError: (() -> Void)? { get set }
    
    func getNumberOfSections(in tableView: UITableView) -> Int
    func getNumberOfOrder(_ tableView: UITableView, section: Int) -> Int
    func getItemOrder(index: Int) -> OrderItems?
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemViewCellHeight() -> CGFloat
}

protocol OrderProtocol: OrderProtocolInput, OrderProtocolOutput {
    var input: OrderProtocolInput { get }
    var output: OrderProtocolOutput { get }
}

class OrderViewModel: OrderProtocol, OrderProtocolOutput {
    var input: OrderProtocolInput { return self }
    var output: OrderProtocolOutput { return self }
    
    // MARK: - UseCase
    private var getOrderUseCase: GetOrderUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Properties
    private var orderViewController: OrderViewController
    
    
    
    init(
        orderViewController: OrderViewController,
        getOrderUseCase: GetOrderUseCase = GetOrderUseCaseImpl()
    ) {
        self.orderViewController = orderViewController
        self.getOrderUseCase = getOrderUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetOrderSuccess: (() -> Void)?
    var didGetOrderError: (() -> Void)?
    
    fileprivate var listOrder: [OrderItems]? = []
    
    func getOrder() {
        self.listOrder?.removeAll()
        self.orderViewController.startLoding()
        
        self.getOrderUseCase.execute().sink { completion in
            debugPrint("getShipment \(completion)")
        } receiveValue: { resp in
            if let items = resp?.data?.items {
                self.listOrder = items
            }
            self.didGetOrderSuccess?()
            self.orderViewController.stopLoding()
        }.store(in: &self.anyCancellable)
    }
    
    func getNumberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func getNumberOfOrder(_ tableView: UITableView, section: Int) -> Int {
        guard let count = listOrder?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemOrder(index: Int) -> OrderItems? {
        guard let itemOrder = listOrder?[index] else { return nil }
        return itemOrder
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier, for: indexPath) as! OrderTableViewCell
        cell.selectionStyle = .none
        cell.items = self.listOrder?[indexPath.item]
        return cell
    }
    
    func getItemViewCellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
}
