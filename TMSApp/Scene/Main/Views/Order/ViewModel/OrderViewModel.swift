//
//  OrderViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/16/21.
//

import Foundation
import RxSwift
import UIKit


enum OrderCollectionPageType {
    case ListOrder
    case Process
}

protocol OrderProtocolInput {
    func getOrder(request: GetOrderRequest)
}

protocol OrderProtocolOutput: class {
    var didGetOrderSuccess: (() -> Void)? { get set }
    var didGetOrderError: (() -> Void)? { get set }
    
    func getSectionTitles() -> [String]
    
    func getNumberOfOrderPage() -> Int
    func getCollectionViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func getItemOrderPage(index: Int) -> [GetOrderResponse]
    
}

protocol OrderProtocol: OrderProtocolInput, OrderProtocolOutput {
    var input: OrderProtocolInput { get }
    var output: OrderProtocolOutput { get }
}

class OrderViewModel: OrderProtocol, OrderProtocolOutput {
    var input: OrderProtocolInput { return self }
    var output: OrderProtocolOutput { return self }
    
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
    
    fileprivate var listCollectionPage = [(name:String, type: OrderCollectionPageType)]()
    
    func getOrder(request: GetOrderRequest) {
        listCollectionPage.removeAll()
        orderViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.listCollectionPage.append((name: "รายการสั่งซื้อ", type: .ListOrder))
            weakSelf.listCollectionPage.append((name: "ดำเนินการ", type: .Process))
            weakSelf.didGetOrderSuccess?()
            weakSelf.orderViewController.stopLoding()
        }
    }
    
    func getSectionTitles() -> [String] {
        var sections: [String] = []
        for item in listCollectionPage {
            sections.append(item.name)
        }
        return sections
    }
    
    func getNumberOfOrderPage() -> Int {
        return listCollectionPage.count
    }
    
    func getCollectionViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.identifier, for: indexPath) as! OrderCollectionViewCell
        cell.listOrder = getItemOrderPage(index: indexPath.item)
        
        print(getItemOrderPage(index: indexPath.item).count)
        return cell
    }
    
    func getItemOrderPage(index: Int) -> [GetOrderResponse] {
        var listOrder: [GetOrderResponse] = []
        for _ in 0..<3 {
            listOrder.append(GetOrderResponse(title: "test"))
        }
        return listOrder
    }
}
