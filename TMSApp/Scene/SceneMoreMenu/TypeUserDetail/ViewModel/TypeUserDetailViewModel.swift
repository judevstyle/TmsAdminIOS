//
//  TypeUserDetailViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import Foundation
import UIKit
import Combine

protocol TypeUserDetailProtocolInput {
    func setItemTypeUserData(item: TypeUserData?)
    func getProduct()
}

protocol TypeUserDetailProtocolOutput: class {
    var didGetProductSuccess: (() -> Void)? { get set }
    
    func getItemDetial() -> TypeUserData?
    
    func getNumberOfCollection() -> Int
    func getItem(index: Int) -> ProductSpecialForTypeUserItems?
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

protocol TypeUserDetailProtocol: TypeUserDetailProtocolInput, TypeUserDetailProtocolOutput {
    var input: TypeUserDetailProtocolInput { get }
    var output: TypeUserDetailProtocolOutput { get }
}

class TypeUserDetailViewModel: TypeUserDetailProtocol, TypeUserDetailProtocolOutput {
    var input: TypeUserDetailProtocolInput { return self }
    var output: TypeUserDetailProtocolOutput { return self }
    
    // MARK: - Properties
    private var typeUserDetailViewController: TypeUserDetailViewController
    // MARK: - UseCase
    private var getProductSpecialForTypeUserUseCase: GetProductSpecialForTypeUserUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    init(
        typeUserDetailViewController: TypeUserDetailViewController,
        getProductSpecialForTypeUserUseCase: GetProductSpecialForTypeUserUseCase = GetProductSpecialForTypeUserUseCaseImpl()
    ) {
        self.typeUserDetailViewController = typeUserDetailViewController
        self.getProductSpecialForTypeUserUseCase = getProductSpecialForTypeUserUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetProductSuccess: (() -> Void)?
    
    fileprivate var listProduct: [ProductSpecialForTypeUserItems]? = []
    fileprivate var itemTypeUser: TypeUserData?
    
    func setItemTypeUserData(item: TypeUserData?) {
        self.itemTypeUser = item
    }
    
    func getProduct() {
        self.listProduct?.removeAll()
        self.typeUserDetailViewController.startLoding()
        guard let typeUserId = self.itemTypeUser?.typeUserId else { return }
        self.getProductSpecialForTypeUserUseCase.execute(typeUserId: typeUserId).sink { completion in
            debugPrint("getProductSpecialForTypeUser \(completion)")
        } receiveValue: { resp in
            if let items = resp?.items {
                self.listProduct = items
            }
            self.didGetProductSuccess?()
            self.typeUserDetailViewController.stopLoding()
        }.store(in: &self.anyCancellable)
        
    }
    
    func getItemDetial() -> TypeUserData? {
        return self.itemTypeUser
    }
    
    func getNumberOfCollection() -> Int {
        guard let count = listProduct?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItem(index: Int) -> ProductSpecialForTypeUserItems? {
        guard let itemMenu = listProduct?[index] else { return nil }
        return itemMenu
    }
    
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        cell.itemsProductSpecial = self.listProduct?[indexPath.item]
        return cell
    }
    
}
