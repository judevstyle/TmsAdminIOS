//
//  ProductDetailDetailViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 28/6/2564 BE.
//

import Foundation
import UIKit
import Combine

protocol ProductDetailProtocolInput {
    func getProductDetail()
    func setProductId(productId: Int)
}

protocol ProductDetailProtocolOutput: class {
    var didGetProductDetailSuccess: (() -> Void)? { get set }
    
    func getProductDetail() -> Product?
}

protocol ProductDetailProtocol: ProductDetailProtocolInput, ProductDetailProtocolOutput {
    var input: ProductDetailProtocolInput { get }
    var output: ProductDetailProtocolOutput { get }
}

class ProductDetailViewModel: ProductDetailProtocol, ProductDetailProtocolOutput {
    var input: ProductDetailProtocolInput { return self }
    var output: ProductDetailProtocolOutput { return self }
    
    // MARK: - Properties
    private var productDetailViewController: ProductDetailViewController
    // MARK: - UserCase
    private var getProductDetailUseCase: GetProductDetailUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(
        productDetailViewController: ProductDetailViewController,
        getProductDetailUseCase: GetProductDetailUseCase = GetProductDetailUseCaseImpl()
    ) {
        self.productDetailViewController = productDetailViewController
        self.getProductDetailUseCase = getProductDetailUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetProductDetailSuccess: (() -> Void)?
    
    fileprivate var productId: Int?
    fileprivate var productDetail: Product?
    
    func setProductId(productId: Int) {
        self.productId = productId
    }
    
    func getProductDetail() {
        productDetailViewController.startLoding()
        guard let productId = self.productId else { return }
        self.getProductDetailUseCase.execute(productId: productId).sink { completion in
            debugPrint("getProductDetail \(completion)")
            self.productDetailViewController.stopLoding()
        } receiveValue: { resp in
            if let items = resp {
                self.productDetail = items
            }
            self.didGetProductDetailSuccess?()
        }.store(in: &self.anyCancellable)
    }
    
    func getProductDetail() -> Product? {
        return self.productDetail
    }
}
