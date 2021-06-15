//
//  CollectionViewImageGridViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import RxSwift
import UIKit

protocol CollectionViewImageGridProtocolInput {
    func setList()
}

protocol CollectionViewImageGridProtocolOutput: class {
    var didSetMenuSuccess: (() -> Void)? { get set }
    
    func getNumberOfCollection() -> Int
    func getItem(index: Int) -> GetMenuResponse?
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

protocol CollectionViewImageGridProtocol: CollectionViewImageGridProtocolInput, CollectionViewImageGridProtocolOutput {
    var input: CollectionViewImageGridProtocolInput { get }
    var output: CollectionViewImageGridProtocolOutput { get }
}

class CollectionViewImageGridViewModel: CollectionViewImageGridProtocol, CollectionViewImageGridProtocolOutput {
    var input: CollectionViewImageGridProtocolInput { return self }
    var output: CollectionViewImageGridProtocolOutput { return self }
    
    // MARK: - Properties
    
    init(
    ) {
    }
    
    // MARK - Data-binding OutPut
    var didSetMenuSuccess: (() -> Void)?
    
    fileprivate var listImage: [GetMenuResponse]? = []
    
    func setList() {
        listImage?.append(GetMenuResponse(title: "Shipment", image: "08"))
        listImage?.append(GetMenuResponse(title: "Asset", image: "08"))
        listImage?.append(GetMenuResponse(title: "ของแลก", image: "08"))
        listImage?.append(GetMenuResponse(title: "ของแลก", image: "08"))
        listImage?.append(GetMenuResponse(title: "ของแลก", image: "08"))
        listImage?.append(GetMenuResponse(title: "ของแลก", image: "08"))
        self.didSetMenuSuccess?()
    }
    
    func getNumberOfCollection() -> Int {
        guard let count = listImage?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItem(index: Int) -> GetMenuResponse? {
        guard let itemMenu = listImage?[index] else { return nil }
        return itemMenu
    }
    
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Image1x1ChooseCollectionViewCell.identifier, for: indexPath) as! Image1x1ChooseCollectionViewCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Image1x1CollectionViewCell.identifier, for: indexPath) as! Image1x1CollectionViewCell
            cell.delegate = self
            cell.index = indexPath.row
            return cell
        }
    }
    
    private func deleteItem(index: Int){
        listImage?.remove(at: index)
        self.didSetMenuSuccess?()
    }
    
}

extension CollectionViewImageGridViewModel: Image1x1CollectionViewCellDelegate {
    func didDeleteAction(index: Int) {
        self.deleteItem(index: index)
    }
}
