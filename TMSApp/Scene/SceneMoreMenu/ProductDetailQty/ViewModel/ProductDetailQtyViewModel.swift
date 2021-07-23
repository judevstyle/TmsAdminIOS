//
//  ProductDetailQtyViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/18/21.
//

import Foundation
import UIKit
import Combine

public protocol ProductDetailQtyViewModelDelegate {
    func didConfirmQtyProductComplete()
}

protocol ProductDetailQtyProtocolInput {
    func setData(shipmentId: Int?, itemProduct: Product?, typeAction: TypeProductQtyAction, delegate: ProductDetailQtyViewModelDelegate, qty: Int?)
    func didConfirmQtyProduct(qty: Int)
}

protocol ProductDetailQtyProtocolOutput: class {
    var didGetProductSuccess: (() -> Void)? { get set }
    
    func getItemProduct() -> Product?
    
    func getShipmentId() -> Int?
    func getTypeAction() -> TypeProductQtyAction?
    func getMaxQty() -> Int?
}

protocol ProductDetailQtyProtocol: ProductDetailQtyProtocolInput, ProductDetailQtyProtocolOutput {
    var input: ProductDetailQtyProtocolInput { get }
    var output: ProductDetailQtyProtocolOutput { get }
}

class ProductDetailQtyViewModel: ProductDetailQtyProtocol, ProductDetailQtyProtocolOutput {
    
    var input: ProductDetailQtyProtocolInput { return self }
    var output: ProductDetailQtyProtocolOutput { return self }
    
    // MARK: - Properties
    private var productDetailQtyViewController: ProductDetailQtyViewController
    
    // MARK: - UseCase
    private var  postShipmentStockUseCase: PostShipmentStockUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    public var delegate: ProductDetailQtyViewModelDelegate?
    
    init(
        productDetailQtyViewController: ProductDetailQtyViewController,
        postShipmentStockUseCase: PostShipmentStockUseCase = PostShipmentStockUseCaseImpl()
    ) {
        self.productDetailQtyViewController = productDetailQtyViewController
        self.postShipmentStockUseCase = postShipmentStockUseCase
    }

    fileprivate var itemProduct: Product?
    fileprivate var shipmentId: Int?
    fileprivate var typeAction: TypeProductQtyAction = .add
    fileprivate var qty: Int?
    
    // MARK - Data-binding OutPut
    var didGetProductSuccess: (() -> Void)?
    
    func setData(shipmentId: Int?, itemProduct: Product?, typeAction: TypeProductQtyAction, delegate: ProductDetailQtyViewModelDelegate, qty: Int? = 0) {
        self.shipmentId = shipmentId
        self.itemProduct = itemProduct
        self.typeAction = typeAction
        self.delegate = delegate
        self.qty = qty
    }
    
    func didConfirmQtyProduct(qty: Int) {
        let shipmentStock = ShipmentStockManager.shared.getListSelectShipmentStock()

        var requestShipmentStock: PostShipmentStockRequest = PostShipmentStockRequest()
        var isMatchItem: Bool = false
        shipmentStock.forEach({ item in
            if item.productId == itemProduct?.productId {
                isMatchItem = true
                requestShipmentStock = item
            }
        })
        
        if isMatchItem == true {
            let oldQty = requestShipmentStock.qty ?? 0
            requestShipmentStock.qty = oldQty + qty
        } else {
            requestShipmentStock.shipmentId = self.shipmentId
            requestShipmentStock.productId = self.itemProduct?.productId
            requestShipmentStock.qty = qty
            requestShipmentStock.mark = 0
            requestShipmentStock.status = "R"
        }
        
        var newList: [PostShipmentStockRequest] = []
        shipmentStock.forEach({ item in
            if requestShipmentStock.productId == item.productId {
                
            } else {
                newList.append(item)
            }
        })
        
        newList.append(requestShipmentStock)
        
        ShipmentStockManager.shared.setListSelectShipmentStock(items: newList)
        
        self.productDetailQtyViewController.dismiss(animated: true, completion: nil)
    }
    
    func getItemProduct() -> Product? {
        return self.itemProduct
    }
    
    func getShipmentId() -> Int? {
        return self.shipmentId
    }
    
    func getTypeAction() -> TypeProductQtyAction? {
        return self.typeAction
    }
    
    func getMaxQty() -> Int? {
        return self.qty
    }
    
}



public enum TypeProductQtyAction {
    case add
    case remove
}
