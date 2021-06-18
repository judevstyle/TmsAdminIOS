//
//  TypeUserProductAllViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import Foundation
import RxSwift
import UIKit

protocol TypeUserProductAllProtocolInput {
    func getCategory()
    func getProduct(cmsId: String)
    func didSelectItemAt(_ collectionView: UICollectionView, indexPath: IndexPath, type: TypeUserCollectionType)
    func didSelectCategory(index: Int)
    func didSelectProduct(index: Int)
}

protocol TypeUserProductAllProtocolOutput: class {
    var didGetCategorySuccess: (() -> Void)? { get set }
    var didGetProductSuccess: (() -> Void)? { get set }
    
    func getNumberOfCollection(type: TypeUserCollectionType) -> Int
    func getItem(index: Int) -> GetMenuResponse?
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath, type: TypeUserCollectionType) -> UICollectionViewCell
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
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        typeUserProductAllViewController: TypeUserProductAllViewController
    ) {
        self.typeUserProductAllViewController = typeUserProductAllViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetProductSuccess: (() -> Void)?
    var didGetCategorySuccess: (() -> Void)?
    
    fileprivate var listCategory: [GetMenuResponse]? = []
    fileprivate var listProduct: [GetMenuResponse]? = []
    
    func getCategory() {
        listCategory?.removeAll()
        listCategory?.append(GetMenuResponse(title: "Shipment", image: "08"))
        listCategory?.append(GetMenuResponse(title: "Shipment", image: "08"))
        listCategory?.append(GetMenuResponse(title: "Shipment", image: "08"))
        
        listCategory?.append(GetMenuResponse(title: "Shipment", image: "08"))
        listCategory?.append(GetMenuResponse(title: "Shipment", image: "08"))
        listCategory?.append(GetMenuResponse(title: "Shipment", image: "08"))
        
        listCategory?.append(GetMenuResponse(title: "Shipment", image: "08"))
        listCategory?.append(GetMenuResponse(title: "Shipment", image: "08"))
        listCategory?.append(GetMenuResponse(title: "Shipment", image: "08"))
        self.didGetCategorySuccess?()
    }
    
    func getProduct(cmsId: String) {
        listProduct?.removeAll()
        listProduct?.append(GetMenuResponse(title: "Shipment", image: "08"))
        listProduct?.append(GetMenuResponse(title: "Asset", image: "08"))
        listProduct?.append(GetMenuResponse(title: "ของแลก", image: "08"))
        listProduct?.append(GetMenuResponse(title: "ของแลก", image: "08"))
        listProduct?.append(GetMenuResponse(title: "ของแลก", image: "08"))
        listProduct?.append(GetMenuResponse(title: "ของแลก", image: "08"))
        self.didGetProductSuccess?()
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
        self.getProduct(cmsId: "")
    }
    
    func didSelectProduct(index: Int) {
        NavigationManager.instance.pushVC(to: .typeUserProductDetail, presentation: .BottomSheet(completion: {
            print("TEST")
        }, height: 646))
    }
    
    func getNumberOfCollection(type: TypeUserCollectionType) -> Int {
        switch type {
        case .category:
            return self.listCategory?.count ?? 0
        default:
            return self.listProduct?.count ?? 0
        }
    }
    
    func getItem(index: Int) -> GetMenuResponse? {
        guard let itemMenu = listProduct?[index] else { return nil }
        return itemMenu
    }
    
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath, type: TypeUserCollectionType) -> UICollectionViewCell {
        switch type {
        case .category:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCategoryCollectionViewCell.identifier, for: indexPath) as! ProductCategoryCollectionViewCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
            return cell
        }
    }
    
}


enum TypeUserCollectionType {
    case category
    case product
}
