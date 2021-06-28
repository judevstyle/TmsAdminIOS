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
    func setItemTypeUserData(item: TypeUserData?)
    func getCategory()
    func getProduct(typeUserId: Int?, productTypeId: Int?)
    func didSelectItemAt(_ collectionView: UICollectionView, indexPath: IndexPath, type: TypeUserCollectionType)
    func didSelectCategory(index: Int)
    func didSelectProduct(index: Int)
}

protocol TypeUserProductAllProtocolOutput: class {
    var didGetCategorySuccess: (() -> Void)? { get set }
    var didGetProductSuccess: (() -> Void)? { get set }
    
    func getNumberOfCollection(type: TypeUserCollectionType) -> Int
    func getItem(index: Int) -> Product?
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath, type: TypeUserCollectionType) -> UICollectionViewCell
    
    func getTitleCategory(indexPath: IndexPath) -> String
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
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    init(
        typeUserProductAllViewController: TypeUserProductAllViewController,
        getProductTypeUseCase: GetProductTypeUseCase = GetProductTypeUseCaseImpl(),
        getProductForTypeUserUseCase: GetProductForTypeUserUseCase = GetProductForTypeUserUseCaseImpl()
    ) {
        self.typeUserProductAllViewController = typeUserProductAllViewController
        self.getProductTypeUseCase = getProductTypeUseCase
        self.getProductForTypeUserUseCase = getProductForTypeUserUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetProductSuccess: (() -> Void)?
    var didGetCategorySuccess: (() -> Void)?
    
    fileprivate var itemTypeUser: TypeUserData?
    fileprivate var listCategory: [ProductType]? = []
    fileprivate var listProduct: [Product]? = []
    fileprivate var selectedIndex: Int = 0
    
    func setItemTypeUserData(item: TypeUserData?) {
        self.itemTypeUser = item
    }
    
    func getCategory() {
        listCategory?.removeAll()
        self.typeUserProductAllViewController.startLoding()
        self.getProductTypeUseCase.execute().sink { completion in
            debugPrint("getProductType \(completion)")
            self.typeUserProductAllViewController.stopLoding()
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
        self.typeUserProductAllViewController.startLoding()
        self.getProductForTypeUserUseCase.execute(typeUserId: typeUserId, productTypeId: productTypeId).sink { completion in
            debugPrint("getProductForTypeUser \(completion)")
            self.typeUserProductAllViewController.stopLoding()
        } receiveValue: { resp in
            if let items = resp?.items {
                self.listProduct = items
            }
            self.didGetProductSuccess?()
        }.store(in: &self.anyCancellable)
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
            guard let itemTypeUser = self.itemTypeUser,
                  let typeUserId = itemTypeUser.typeUserId else { return }
            getProduct(typeUserId: typeUserId, productTypeId: nil)
            break
        default:
            guard let itemCategory = self.listCategory?[index - 1],
                  let itemTypeUser = self.itemTypeUser,
                  let typeUserId = itemTypeUser.typeUserId,
                  let productTypeId = itemCategory.productTypeId else { return }
            getProduct(typeUserId: typeUserId, productTypeId: productTypeId)
        }
    }
    
    func didSelectProduct(index: Int) {
        
        guard let itemTypeUser = self.itemTypeUser,
              let itemProduct = self.listProduct?[index]  else { return }
        NavigationManager.instance.pushVC(to: .typeUserProductDetail(
                                            itemTypeUser: itemTypeUser,
                                            itemProduct: itemProduct,
                                            itemProductSpecial: nil,
                                            typeAction: .create, delegate: self), presentation: .BottomSheet(completion: {
        }, height: 620))

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
