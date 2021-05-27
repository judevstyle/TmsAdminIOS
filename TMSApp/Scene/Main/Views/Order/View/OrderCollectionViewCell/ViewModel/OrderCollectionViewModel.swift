//
//  OrderCollectionViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/26/21.
//

import Foundation


import Foundation
import RxSwift
import UIKit

protocol OrderCollectionProtocolInput {
    func fetchOrder(_ orders: [GetOrderResponse]?)
}

protocol OrderCollectionProtocolOutput: class {
    var didGetOrderSuccess: (() -> Void)? { get set }
    var didGetOrderError: (() -> Void)? { get set }
    
    func getNumberOfOrder() -> Int
    func getItemOrder(index: Int) -> GetOrderResponse?
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemViewCellHeight() -> CGFloat
}

protocol OrderCollectionProtocol: OrderCollectionProtocolInput, OrderCollectionProtocolOutput {
    var input: OrderCollectionProtocolInput { get }
    var output: OrderCollectionProtocolOutput { get }
}

class OrderCollectionViewModel: OrderCollectionProtocol, OrderCollectionProtocolOutput {
    var input: OrderCollectionProtocolInput { return self }
    var output: OrderCollectionProtocolOutput { return self }
    
    // MARK: - Properties
    private var orderCollectionViewCell: OrderCollectionViewCell
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        orderCollectionViewCell: OrderCollectionViewCell
    ) {
        self.orderCollectionViewCell = orderCollectionViewCell
    }
    
    // MARK - Data-binding OutPut
    var didGetOrderSuccess: (() -> Void)?
    var didGetOrderError: (() -> Void)?
    
    fileprivate var listOrder: [GetOrderResponse]? = []
    
    func fetchOrder(_ orders: [GetOrderResponse]?) {
        self.listOrder = orders
        didGetOrderSuccess?()
    }
    
    func getNumberOfOrder() -> Int {
        guard let count = listOrder?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemOrder(index: Int) -> GetOrderResponse? {
        guard let itemOrder = listOrder?[index] else { return nil }
        return itemOrder
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier, for: indexPath) as! OrderTableViewCell
        cell.selectionStyle = .none
        cell.setData(item: getItemOrder(index: indexPath.item))
        return cell
    }
    
    func getItemViewCellHeight() -> CGFloat {
        return 147
    }
}
