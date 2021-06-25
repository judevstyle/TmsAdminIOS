//
//  DashBoardProductTableViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 25/6/2564 BE.
//

import Foundation
import UIKit

protocol DashBoardProductTableProtocolInput {
    func setDashBoardProduct(products: [TotalOrderProduct])
}

protocol DashBoardProductTableProtocolOutput: class {
    var didGetDashBoardProductTableSuccess: (() -> Void)? { get set }
    var didGetDashBoardProductTableError: (() -> Void)? { get set }
    
    func getNumberOfItems() -> Int
    func getItemDashBoardProductTable(index: Int) -> TotalOrderProduct?
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

protocol DashBoardProductTableProtocol: DashBoardProductTableProtocolInput, DashBoardProductTableProtocolOutput {
    var input: DashBoardProductTableProtocolInput { get }
    var output: DashBoardProductTableProtocolOutput { get }
}

class DashBoardProductTableViewModel: DashBoardProductTableProtocol, DashBoardProductTableProtocolOutput {
    var input: DashBoardProductTableProtocolInput { return self }
    var output: DashBoardProductTableProtocolOutput { return self }
    
    // MARK: - Properties

    
    init(
    ) {
    }
    
    // MARK - Data-binding OutPut
    var didGetDashBoardProductTableSuccess: (() -> Void)?
    var didGetDashBoardProductTableError: (() -> Void)?
    
    fileprivate var listDashBoardProductTable: [TotalOrderProduct]? = []
    
    func setDashBoardProduct(products: [TotalOrderProduct]) {
        listDashBoardProductTable?.removeAll()
        listDashBoardProductTable? = products
        self.didGetDashBoardProductTableSuccess?()
    }
    
    func getNumberOfItems() -> Int {
        guard let count = listDashBoardProductTable?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemDashBoardProductTable(index: Int) -> TotalOrderProduct? {
        guard let itemDashBoardProductTable = listDashBoardProductTable?[index] else { return nil }
        return itemDashBoardProductTable
    }
    
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashBoardProductCollectionViewCell.identifier, for: indexPath) as! DashBoardProductCollectionViewCell
        
        cell.product = self.listDashBoardProductTable?[indexPath.item]
        return cell
    }
}
