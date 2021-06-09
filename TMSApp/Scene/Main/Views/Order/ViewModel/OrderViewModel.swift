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
    
    func getNumberOfSections(in tableView: UITableView) -> Int
    func getNumberOfOrder(_ tableView: UITableView, section: Int) -> Int
    func getItemOrder(index: Int) -> GetOrderResponse?
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemViewCellHeight() -> CGFloat
    func getItemOrderPage(index: Int) -> [GetOrderResponse]
    func getHeightSectionView(section: Int) -> CGFloat
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView?
}

protocol OrderProtocol: OrderProtocolInput, OrderProtocolOutput {
    var input: OrderProtocolInput { get }
    var output: OrderProtocolOutput { get }
}

class OrderViewModel: OrderProtocol, OrderProtocolOutput {
    var input: OrderProtocolInput { return self }
    var output: OrderProtocolOutput { return self }
    
    // MARK: - Properties
    // MARK: - Properties
    private var orderViewController: OrderViewController
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        orderViewController: OrderViewController
    ) {
        self.orderViewController = orderViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetOrderSuccess: (() -> Void)?
    var didGetOrderError: (() -> Void)?
    
    fileprivate var listOrder: [GetOrderResponse]? = []
    
    func getOrder(request: GetOrderRequest) {
        self.listOrder = getItemOrderPage(index: 0)
        didGetOrderSuccess?()
    }
    
    func getNumberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func getNumberOfOrder(_ tableView: UITableView, section: Int) -> Int {
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
    
    func getItemOrderPage(index: Int) -> [GetOrderResponse] {
        var listOrder: [GetOrderResponse] = []
        for _ in 0..<3 {
            listOrder.append(GetOrderResponse(title: "test"))
        }
        return listOrder
    }
    
    func getHeightSectionView(section: Int) -> CGFloat {
        let headerHeight: CGFloat
        switch section {
        case 0:
            // hide the header
            headerHeight = CGFloat.leastNonzeroMagnitude
        default:
            headerHeight = 30
        }
        return headerHeight
    }
    
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: OrderHeaderTableViewCell.identifier)
            if let header = header as? OrderHeaderTableViewCell {
                header.render(title: "รายการสินค้า")
            }
            return header
        }
    }
}
