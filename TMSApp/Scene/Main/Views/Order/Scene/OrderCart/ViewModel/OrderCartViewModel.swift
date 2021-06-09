//
//  OrderCartViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/30/21.
//

import Foundation
import RxSwift
import UIKit

protocol OrderCartProtocolInput {
    func fetchOrderCart()
}

protocol OrderCartProtocolOutput: class {
    var didGetOrderCartSuccess: (() -> Void)? { get set }
    var didGetOrderCartError: (() -> Void)? { get set }
    
    func getNumberOfSections(in tableView: UITableView) -> Int
    func getNumberOfOrderCart(_ tableView: UITableView, section: Int) -> Int
    func getItemOrderCart(index: Int) -> GetOrderResponse?
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemViewCellHeight() -> CGFloat
    func getHeightSectionView(section: Int) -> CGFloat
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView?
}

protocol OrderCartProtocol: OrderCartProtocolInput, OrderCartProtocolOutput {
    var input: OrderCartProtocolInput { get }
    var output: OrderCartProtocolOutput { get }
}

class OrderCartViewModel: OrderCartProtocol, OrderCartProtocolOutput {
    var input: OrderCartProtocolInput { return self }
    var output: OrderCartProtocolOutput { return self }
    
    // MARK: - Properties
    private var orderCartViewController: OrderCartViewController
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        orderCartViewController: OrderCartViewController
    ) {
        self.orderCartViewController = orderCartViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetOrderCartSuccess: (() -> Void)?
    var didGetOrderCartError: (() -> Void)?
    
    fileprivate var listOrderCart: [GetOrderResponse]? = []
    
    func fetchOrderCart() {
        self.orderCartViewController.startLoding()
        self.listOrderCart?.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<5 {
                weakSelf.listOrderCart?.append(GetOrderResponse(title: "sss"))
            }
            weakSelf.didGetOrderCartSuccess?()
            weakSelf.orderCartViewController.stopLoding()
        }
        
    }
    func getNumberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func getNumberOfOrderCart(_ tableView: UITableView, section: Int) -> Int {
        guard let count = listOrderCart?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemOrderCart(index: Int) -> GetOrderResponse? {
        guard let itemOrder = listOrderCart?[index] else { return nil }
        return itemOrder
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCartTableViewCell.identifier, for: indexPath) as! OrderCartTableViewCell
        cell.selectionStyle = .none
        cell.setData(item: listOrderCart?[indexPath.item])
        return cell
    }
    
    func getItemViewCellHeight() -> CGFloat {
        return 147
    }
    
    func getHeightSectionView(section: Int) -> CGFloat {
        return 30
    }
    
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: OrderCartHeaderTableViewCell.identifier)
        if let header = header as? OrderCartHeaderTableViewCell {
            header.render(title: "รายการสินค้า")
        }
        return header
    }
}
