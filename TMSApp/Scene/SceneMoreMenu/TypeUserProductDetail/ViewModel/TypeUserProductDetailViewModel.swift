//
//  TypeUserProductDetailViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import UIKit
import Combine

public protocol TypeUserProductDetailViewModelDelegate {
    func didConfirmmNewProductComplete()
}

protocol TypeUserProductDetailProtocolInput {
    func setData(itemTypeUser: TypeUserData?, itemProduct: Product?, itemProductSpecial: ProductSpecialForTypeUserItems?, typeAction: TypeUserProductDetailAction, delegate: TypeUserProductDetailViewModelDelegate)
    func didConfirmmNewProduct(newPrice: String)
    func didDeleteProduct()
}

protocol TypeUserProductDetailProtocolOutput: class {
    var didGetProductSuccess: (() -> Void)? { get set }
    
    func getItemProduct() -> Product?
    func getItemProductSpecial() -> ProductSpecialForTypeUserItems?
    func getItemTypeUser() -> TypeUserData?
    func getTypeAction() -> TypeUserProductDetailAction
}

protocol TypeUserProductDetailProtocol: TypeUserProductDetailProtocolInput, TypeUserProductDetailProtocolOutput {
    var input: TypeUserProductDetailProtocolInput { get }
    var output: TypeUserProductDetailProtocolOutput { get }
}

class TypeUserProductDetailViewModel: TypeUserProductDetailProtocol, TypeUserProductDetailProtocolOutput {
    
    var input: TypeUserProductDetailProtocolInput { return self }
    var output: TypeUserProductDetailProtocolOutput { return self }
    
    // MARK: - Properties
    private var typeUserProductDetailViewController: TypeUserProductDetailViewController
    
    // MARK: - UseCase
    private var postProductSpecialForTypeUserUseCase: PostProductSpecialForTypeUserUseCase
    private var putProductSpecialForTypeUserUseCase: PutProductSpecialForTypeUserUseCase
    private var deleteProductSpecialForTypeUserUseCase: DeleteProductSpecialForTypeUserUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    public var delegate: TypeUserProductDetailViewModelDelegate?
    
    init(
        typeUserProductDetailViewController: TypeUserProductDetailViewController,
        postProductSpecialForTypeUserUseCase: PostProductSpecialForTypeUserUseCase = PostProductSpecialForTypeUserUseCaseImpl(),
        putProductSpecialForTypeUserUseCase: PutProductSpecialForTypeUserUseCase = PutProductSpecialForTypeUserUseCaseImpl(),
        deleteProductSpecialForTypeUserUseCase: DeleteProductSpecialForTypeUserUseCase = DeleteProductSpecialForTypeUserUseCaseImpl()
    ) {
        self.typeUserProductDetailViewController = typeUserProductDetailViewController
        self.postProductSpecialForTypeUserUseCase = postProductSpecialForTypeUserUseCase
        self.putProductSpecialForTypeUserUseCase = putProductSpecialForTypeUserUseCase
        self.deleteProductSpecialForTypeUserUseCase = deleteProductSpecialForTypeUserUseCase
    }
    
    fileprivate var itemTypeUser: TypeUserData?
    //for Create
    fileprivate var itemProduct: Product?
    //for Update
    fileprivate var itemProductSpecial: ProductSpecialForTypeUserItems?
    
    fileprivate var typeAction: TypeUserProductDetailAction = .create
    
    // MARK - Data-binding OutPut
    var didGetProductSuccess: (() -> Void)?
    
    func setData(itemTypeUser: TypeUserData?, itemProduct: Product?, itemProductSpecial: ProductSpecialForTypeUserItems?, typeAction: TypeUserProductDetailAction, delegate: TypeUserProductDetailViewModelDelegate) {
        self.itemTypeUser = itemTypeUser
        self.itemProduct = itemProduct
        self.itemProductSpecial = itemProductSpecial
        self.typeAction = typeAction
        self.delegate = delegate
    }
    
    func didConfirmmNewProduct(newPrice: String) {
        guard let itemTypeUser = self.itemTypeUser else { return }
        if self.typeAction == .create {
            guard let itemProduct = self.itemProduct else { return }
            var request = PostProductSpecialForTypeUserRequest()
            request.typeUserId = itemTypeUser.typeUserId
            request.itemPrice = Int(newPrice)
            var product = ProductSpecialForTypeUserRequest()
            product.product_id = itemProduct.productId
            request.products = [product]
            self.postProductSpecialForTypeUserUseCase.execute(request: request).sink { completion in
                debugPrint("postProductSpecialForType \(completion)")
                self.typeUserProductDetailViewController.stopLoding()
            } receiveValue: { resp in
                if let items = resp {
                    if items.success == true {
                        self.typeUserProductDetailViewController.dismiss(animated: true, completion: nil)
                        self.delegate?.didConfirmmNewProductComplete()
                    }
                }
            }.store(in: &self.anyCancellable)
        } else if self.typeAction == .update {
            guard let itemProductSpecial = self.itemProductSpecial,
                  let productSpcId = itemProductSpecial.productSpcId  else { return }
            var request = PutProductSpecialForTypeUserRequest()
            request.typeUserId = itemTypeUser.typeUserId
            request.itemPrice = Int(newPrice)
            var product = ProductSpecialForTypeUserRequest()
            product.product_id = itemProductSpecial.product?.productId
            request.products = product
            self.putProductSpecialForTypeUserUseCase.execute(
                request: request,
                productSpcIid: productSpcId).sink { completion in
                debugPrint("putProductSpecialForType \(completion)")
                self.typeUserProductDetailViewController.stopLoding()
                    
                    switch completion {
                    case .finished:
                        ToastManager.shared.toastCallAPI(title: "PutProductSpecialForType finished")
                        break
                    case .failure(_):
                        ToastManager.shared.toastCallAPI(title: "PutProductSpecialForType failure")
                        break
                    }
                    
            } receiveValue: { resp in
                if let items = resp {
                    if items.success == true {
                        self.typeUserProductDetailViewController.dismiss(animated: true, completion: nil)
                        self.delegate?.didConfirmmNewProductComplete()
                    }
                }
            }.store(in: &self.anyCancellable)
        }
    }
    
    func didDeleteProduct() {
        if self.typeAction == .update {
            guard let itemProductSpecial = self.itemProductSpecial,
                  let productSpcId = itemProductSpecial.productSpcId  else { return }
            self.deleteProductSpecialForTypeUserUseCase.execute(productSpcIid: productSpcId).sink { completion in
                debugPrint("deleteProductSpecialForTypeUser \(completion)")
                self.typeUserProductDetailViewController.stopLoding()
                
                switch completion {
                case .finished:
                    ToastManager.shared.toastCallAPI(title: "DeleteProductSpecialForTypeUser finished")
                    break
                case .failure(_):
                    ToastManager.shared.toastCallAPI(title: "DeleteProductSpecialForTypeUser failure")
                    break
                }
                
            } receiveValue: { resp in
                if let items = resp {
                    if items.success == true {
                        self.typeUserProductDetailViewController.dismiss(animated: true, completion: nil)
                        self.delegate?.didConfirmmNewProductComplete()
                    }
                }
            }.store(in: &self.anyCancellable)
        }
    }
    
    func getItemProduct() -> Product? {
        return self.itemProduct
    }
    
    func getItemProductSpecial() -> ProductSpecialForTypeUserItems? {
        return self.itemProductSpecial
    }
    
    func getItemTypeUser() -> TypeUserData? {
        return self.itemTypeUser
    }
    
    func getTypeAction() -> TypeUserProductDetailAction {
        return self.typeAction
    }
    
}

public enum TypeUserProductDetailAction {
    case create
    case update
}
