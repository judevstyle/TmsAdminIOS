//
//  ProductViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import Foundation
import UIKit
import Combine

protocol ProductProtocolInput {
    func getProduct()
}

protocol ProductProtocolOutput: class {
    var didGetProductSuccess: (() -> Void)? { get set }
    var didGetProductError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
    func getItemForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> Product?
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
    // MARK: - UserCase
    private var getProductUseCase: GetProductUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(
        productViewController: ProductViewController,
        getProductUseCase: GetProductUseCase = GetProductUseCaseImpl()
    ) {
        self.productViewController = productViewController
        self.getProductUseCase = getProductUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetProductSuccess: (() -> Void)?
    var didGetProductError: (() -> Void)?
    
    fileprivate var listProduct: [Product]? = []
    
    func getProduct() {
        listProduct?.removeAll()
        productViewController.startLoding()
        var request: GetProductRequest = GetProductRequest()
        request.compId = 1
        
        self.getProductUseCase.execute(request: request).sink { completion in
            debugPrint("getProduct \(completion)")
            self.productViewController.stopLoding()
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetProduct finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "GetProduct failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp?.items {
                self.listProduct = items
            }
            self.didGetProductSuccess?()
        }.store(in: &self.anyCancellable)
    
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
        cell.items = self.listProduct?[indexPath.item]
        return cell
    }
    
    func getItemForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> Product? {
        return self.listProduct?[indexPath.item]
    }
    
}
