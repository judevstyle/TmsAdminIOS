//
//  ProductViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import Foundation
import UIKit
import RxSwift

protocol ProductProtocolInput {
    func getProduct()
}

protocol ProductProtocolOutput: class {
    var didGetProductSuccess: (() -> Void)? { get set }
    var didGetProductError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol ProductProtocol: ProductProtocolInput, ProductProtocolOutput {
    var input: ProductProtocolInput { get }
    var output: ProductProtocolOutput { get }
}

class ProductViewModel: ProductProtocol, ProductProtocolOutput {
    var input: ProductProtocolInput { return self }
    var output: ProductProtocolOutput { return self }
    
    // MARK: - Properties
    private var productViewController: ProductViewController
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        productViewController: ProductViewController
    ) {
        self.productViewController = productViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetProductSuccess: (() -> Void)?
    var didGetProductError: (() -> Void)?
    
    fileprivate var listProduct: [GetAppealResponse]? = []
    
    func getProduct() {
        listProduct?.removeAll()
        productViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<3 {
                weakSelf.listProduct?.append(GetAppealResponse(title: "test"))
            }

            weakSelf.didGetProductSuccess?()
            weakSelf.productViewController.stopLoding()
        }
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listProduct?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}
