//
//  TypeUserProductAllViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import Foundation
import UIKit
import Combine

protocol TypeUserProductAllProtocolInput {
    func setData(item: TypeUserData?, shipmentId: Int?)
    func getCategory()
    func getProduct(typeUserId: Int?, productTypeId: Int?)
    func didSelectItemAt(_ collectionView: UICollectionView, indexPath: IndexPath, type: TypeUserCollectionType)
    func didSelectCategory(index: Int)
    func didSelectProduct(index: Int)
    
    func didSaveShipmentStock()
}

protocol TypeUserProductAllProtocolOutput: class {
    var didGetCategorySuccess: (() -> Void)? { get set }
    var didGetProductSuccess: (() -> Void)? { get set }
    
    func getNumberOfCollection(type: TypeUserCollectionType) -> Int
    func getItem(index: Int) -> Product?
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath, type: TypeUserCollectionType) -> UICollectionViewCell
    
    func getTitleCategory(indexPath: IndexPath) -> String
    
    func getItemTypeUser() -> TypeUserData?
}

protocol TypeUserProductAllProtocol: TypeUserProductAllProtocolInput, TypeUserProductAllProtocolOutput {
    var input: TypeUserProductAllProtocolInput { get }
    var output: TypeUserProductAllProtocolOutput { get }
}

class TypeUserProductAllViewModel: TypeUserProductAllProtocol, TypeUserProductAllProtocolOutput {
    
    var input: TypeUserProductAllProtocolInput { return self }
    var output: TypeUserProductAllProtocolOutput { return self }
    
    // MARK: - Properties
    private var typeUserProductAllViewController: TypeUserProductAllViewController
    
    // MARK: - UseCase
    private var getProductTypeUseCase: GetProductTypeUseCase
    private var getProductForTypeUserUseCase: GetProductForTypeUserUseCase
    private var getProductUseCase: GetProductUseCase
    private var postShipmentStockUseCase: PostShipmentStockUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    init(
        typeUserProductAllViewController: TypeUserProductAllViewController,
        getProductTypeUseCase: GetProductTypeUseCase = GetProductTypeUseCaseImpl(),
        getProductForTypeUserUseCase: GetProductForTypeUserUseCase = GetProductForTypeUserUseCaseImpl(),
        getProductUseCase: GetProductUseCase = GetProductUseCaseImpl(),
        postShipmentStockUseCase: PostShipmentStockUseCase = PostShipmentStockUseCaseImpl()
    ) {
        self.typeUserProductAllViewController = typeUserProductAllViewController
        self.getProductTypeUseCase = getProductTypeUseCase
        self.getProductForTypeUserUseCase = getProductForTypeUserUseCase
        self.getProductUseCase = getProductUseCase
        self.postShipmentStockUseCase = postShipmentStockUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetProductSuccess: (() -> Void)?
    var didGetCategorySuccess: (() -> Void)?
    
    fileprivate var itemTypeUser: TypeUserData?
    fileprivate var listCategory: [ProductType]? = []
    fileprivate var listProduct: [Product]? = []
    fileprivate var selectedIndex: Int = 0
    
    fileprivate var shipmentId: Int?
    
    func setData(item: TypeUserData?, shipmentId: Int?) {
        self.itemTypeUser = item
        self.shipmentId = shipmentId
    }
    
    func getCategory() {
        listCategory?.removeAll()
        self.typeUserProductAllViewController.startLoding()
        self.getProductTypeUseCase.execute().sink { completion in
            debugPrint("getProductType \(completion)")
            self.typeUserProductAllViewController.stopLoding()
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetProductType finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "GetProductType failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp {
                self.listCategory = items
            }
            self.didGetCategorySuccess?()
            self.didSelectCategory(index: 0)
        }.store(in: &self.anyCancellable)
    }
    
    func getProduct(typeUserId: Int?, productTypeId: Int?) {
        listProduct?.removeAll()
        if itemTypeUser != nil && typeUserId != nil {
            self.typeUserProductAllViewController.startLoding()
            self.getProductForTypeUserUseCase.execute(typeUserId: typeUserId, productTypeId: productTypeId).sink { completion in
                debugPrint("getProductForTypeUser \(completion)")
                self.typeUserProductAllViewController.stopLoding()
                
                switch completion {
                case .finished:
                    ToastManager.shared.toastCallAPI(title: "GetProductForTypeUser finished")
                    break
                case .failure(_):
                    ToastManager.shared.toastCallAPI(title: "GetProductForTypeUser failure")
                    break
                }
                
            } receiveValue: { resp in
                if let items = resp?.items {
                    self.listProduct = items
                }
                self.didGetProductSuccess?()
            }.store(in: &self.anyCancellable)
        } else {
            self.typeUserProductAllViewController.startLoding()
            var request: GetProductRequest = GetProductRequest()
            request.compId = 1
            request.productTypeId = productTypeId
            self.getProductUseCase.execute(request: request).sink { completion in
                debugPrint("getProduct \(completion)")
                self.typeUserProductAllViewController.stopLoding()
                
                
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
    }
    
    func didSelectItemAt(_ collectionView: UICollectionView, indexPath: IndexPath, type: TypeUserCollectionType) {
        switch type {
        case .category:
            if let cell = collectionView.cellForItem(at: indexPath) as? ProductCategoryCollectionViewCell {
                cell.isSelected = true
                didSelectCategory(index: indexPath.row)
            }
        case .product:
            didSelectProduct(index: indexPath.row)
        }
    }
    
    func didSelectCategory(index: Int) {
        self.selectedIndex = index
        switch index {
        case 0:
            getProduct(typeUserId: self.itemTypeUser?.typeUserId, productTypeId: nil)
            break
        default:
            let productTypeId = self.listCategory?[index - 1].productTypeId
            getProduct(typeUserId: self.itemTypeUser?.typeUserId, productTypeId: productTypeId)
        }
    }
    
    func didSelectProduct(index: Int) {
        
        if self.itemTypeUser != nil {
            guard let itemTypeUser = self.itemTypeUser,
                  let itemProduct = self.listProduct?[index]  else { return }
            NavigationManager.instance.pushVC(to: .typeUserProductDetail(
                                                itemTypeUser: itemTypeUser,
                                                itemProduct: itemProduct,
                                                itemProductSpecial: nil,
                                                typeAction: .create, delegate: self), presentation: .BottomSheet(completion: {
                                                }, height: 620))
        } else {
            guard let itemProduct = self.listProduct?[index]  else { return }
            NavigationManager.instance.pushVC(to: .productDetailQty(shipmentId: self.shipmentId,
                                                                    itemProduct: itemProduct,
                                                                    typeAction: .add,
                                                                    delegate: self), presentation: .BottomSheet(completion: {
                                                }, height: 588))
        }
        
    }
    
    func getNumberOfCollection(type: TypeUserCollectionType) -> Int {
        switch type {
        case .category:
            return ((self.listCategory?.count ?? 0) + 1)
        default:
            return self.listProduct?.count ?? 0
        }
    }
    
    func getItem(index: Int) -> Product? {
        guard let itemMenu = listProduct?[index] else { return nil }
        return itemMenu
    }
    
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath, type: TypeUserCollectionType) -> UICollectionViewCell {
        switch type {
        case .category:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCategoryCollectionViewCell.identifier, for: indexPath) as! ProductCategoryCollectionViewCell
            switch indexPath.item {
            case 0:
                var item = ProductType()
                item.productTypeName = "ทั้งหมด"
                cell.items = item
            default:
                cell.items = self.listCategory?[indexPath.item - 1]
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
            cell.itemsProduct = self.listProduct?[indexPath.item]
            return cell
        }
    }
    
    func getTitleCategory(indexPath: IndexPath) -> String {
        switch indexPath.item {
        case 0:
            var item = ProductType()
            item.productTypeName = "ทั้งหมด"
            return item.productTypeName ?? ""
            break
        default:
            guard let items = self.listCategory, items.count != 0 else { return "" }
            let item = items[indexPath.item - 1]
            return item.productTypeName ?? ""
        }
    }
    
    func getItemTypeUser() -> TypeUserData? {
        return self.itemTypeUser
    }
    
}

extension TypeUserProductAllViewModel: TypeUserProductDetailViewModelDelegate {
    func didConfirmmNewProductComplete() {
        self.didSelectCategory(index: self.selectedIndex)
    }
}

enum TypeUserCollectionType {
    case category
    case product
}

extension TypeUserProductAllViewModel: ProductDetailQtyViewModelDelegate {
    func didConfirmQtyProductComplete() {
    }
}

// ShipmentStock
extension TypeUserProductAllViewModel {
    func didSaveShipmentStock() {
        let listShipmentStock = ShipmentStockManager.shared.getListSelectShipmentStock()
        if listShipmentStock.count > 0 {
            self.typeUserProductAllViewController.startLoding()
            self.postShipmentStockUseCase.execute(request: listShipmentStock).sink { completion in
                debugPrint("postShipmentStock \(completion)")
                self.typeUserProductAllViewController.stopLoding()
                
                switch completion {
                case .finished:
                    ToastManager.shared.toastCallAPI(title: "PostShipmentStock finished")
                    break
                case .failure(_):
                    ToastManager.shared.toastCallAPI(title: "PostShipmentStock failure")
                    break
                }
                
            } receiveValue: { resp in
                if resp?.success == true {
                    self.typeUserProductAllViewController.navigationController?.popViewController(animated: true)
                    ShipmentStockManager.shared.setListSelectShipmentStock(items: [])
                }
            }.store(in: &self.anyCancellable)
        }
    }
}
