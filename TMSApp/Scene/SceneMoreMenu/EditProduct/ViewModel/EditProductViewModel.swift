//
//  EditProductViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 29/6/2564 BE.
//

import Foundation
import UIKit
import Combine

protocol EditProductProtocolInput {
    func getProductType()
    func createProduct(productCode: String,
                       productName:String,
                       productDesc:String,
                       productDimension:String,
                       productPrice: Double,
                       productPoint: Int,
                       productCountPerPoint: Int,
                       productImg: String,
                       productTypeName: String
    )
}

protocol EditProductProtocolOutput: class {
    var didGetProductTypeSuccess: (() -> Void)? { get set }
    var didGetProductTypeError: (() -> Void)? { get set }
    
    func getListProductType() -> [ProductType]?
}

protocol EditProductProtocol: EditProductProtocolInput, EditProductProtocolOutput {
    var input: EditProductProtocolInput { get }
    var output: EditProductProtocolOutput { get }
}

class EditProductViewModel: EditProductProtocol, EditProductProtocolOutput {
    var input: EditProductProtocolInput { return self }
    var output: EditProductProtocolOutput { return self }
    
    // MARK: - Properties
    private var editProductViewController: EditProductViewController
    // MARK: - UserCase
    private var getProductTypeUseCase: GetProductTypeUseCase
    private var postProductUseCase: PostProductUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(
        editProductViewController: EditProductViewController,
        getProductTypeUseCase: GetProductTypeUseCase = GetProductTypeUseCaseImpl(),
        postProductUseCase: PostProductUseCase = PostProductUseCaseImpl()
    ) {
        self.editProductViewController = editProductViewController
        self.getProductTypeUseCase = getProductTypeUseCase
        self.postProductUseCase = postProductUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetProductTypeSuccess: (() -> Void)?
    var didGetProductTypeError: (() -> Void)?
    
    fileprivate var listProductType: [ProductType]? = []
    
    
    func getProductType() {
        listProductType?.removeAll()
        editProductViewController.startLoding()
        self.getProductTypeUseCase.execute().sink { completion in
            debugPrint("getProductType \(completion)")
            self.editProductViewController.stopLoding()
        } receiveValue: { resp in
            if let items = resp {
                self.listProductType = items
            }
            self.didGetProductTypeSuccess?()
        }.store(in: &self.anyCancellable)
    }
    
    func getListProductType() -> [ProductType]? {
        return self.listProductType
    }
    
    func createProduct(productCode: String, productName: String, productDesc: String, productDimension: String, productPrice: Double, productPoint: Int, productCountPerPoint: Int, productImg: String, productTypeName: String) {
        print("createProduct")
    
        
        var request = PostProductRequest()
        request.compId = 1
        
        if let productType = listProductType?.first(where: { $0.productTypeName == productTypeName }) {
            request.productTypeId = productType.productTypeId
        }
    
        request.productSku = "SKU"
        request.productCode = productCode
        request.productName = productName
        request.productDesc = productDesc
        request.productDimension = productDimension
        request.productPrice = productPrice
        request.productPoint = productPoint
        request.productCountPerPoint = productCountPerPoint
        var requestImage = ProductImgRequest()
        requestImage.url = productImg
        requestImage.del = 0
        request.productImg = requestImage
        
        editProductViewController.startLoding()
        self.postProductUseCase.execute(request: request).sink { completion in
            debugPrint("postProduct \(completion)")
            self.editProductViewController.stopLoding()
        } receiveValue: { resp in
            if let items = resp {
                if items.success == true {
                    self.editProductViewController.navigationController?.popViewController(animated: true)
                }
            }
        }.store(in: &self.anyCancellable)
    }
}
