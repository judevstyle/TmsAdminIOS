//
//  OrderViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/16/21.
//

import Foundation
import RxSwift
import UIKit

protocol OrderProtocolInput {
    func getOrder(request: GetOrderRequest)
}

protocol OrderProtocolOutput: class {
    var didGetOrderSuccess: (() -> Void)? { get set }
    var didGetOrderError: (() -> Void)? { get set }
    
    func getNumberOfOrder() -> Int
    func getItemOrder(index: Int) -> GetOrderResponse?
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
    
    // MARK: - Properties
//    private var getProductUseCase: GetProductUseCase
    private var orderViewController: OrderViewController
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
//        getProductUseCase: GetProductUseCase = GetProductUseCaseImpl(),
        orderViewController: OrderViewController
    ) {
//        self.getProductUseCase = getProductUseCase
        self.orderViewController = orderViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetOrderSuccess: (() -> Void)?
    var didGetOrderError: (() -> Void)?
    
    fileprivate var listOrder: [GetOrderResponse]? = []
    
    func getOrder(request: GetOrderRequest) {
        listOrder?.removeAll()
        orderViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<3 {
                weakSelf.listOrder?.append(GetOrderResponse(title: "test"))
            }

            weakSelf.didGetOrderSuccess?()
            weakSelf.orderViewController.stopLoding()
        }
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
