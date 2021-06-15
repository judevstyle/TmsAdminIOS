//
//  TypeUserDetailViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import Foundation
import RxSwift
import UIKit

protocol TypeUserDetailProtocolInput {
    func getProduct()
}

protocol TypeUserDetailProtocolOutput: class {
    var didGetProductSuccess: (() -> Void)? { get set }
    
    func getNumberOfCollection() -> Int
    func getItem(index: Int) -> GetMenuResponse?
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
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        typeUserDetailViewController: TypeUserDetailViewController
    ) {
        self.typeUserDetailViewController = typeUserDetailViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetProductSuccess: (() -> Void)?
    
    fileprivate var listProduct: [GetMenuResponse]? = []
    
    func getProduct() {
        listProduct?.append(GetMenuResponse(title: "Shipment", image: "08"))
        listProduct?.append(GetMenuResponse(title: "Asset", image: "08"))
        listProduct?.append(GetMenuResponse(title: "ของแลก", image: "08"))
        listProduct?.append(GetMenuResponse(title: "ของแลก", image: "08"))
        listProduct?.append(GetMenuResponse(title: "ของแลก", image: "08"))
        listProduct?.append(GetMenuResponse(title: "ของแลก", image: "08"))
        self.didGetProductSuccess?()
    }
    
    func getNumberOfCollection() -> Int {
        guard let count = listProduct?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItem(index: Int) -> GetMenuResponse? {
        guard let itemMenu = listProduct?[index] else { return nil }
        return itemMenu
    }
    
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        return cell
    }
    
}
