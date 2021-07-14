//
//  SortSortShipmentViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import Foundation
import UIKit
import Combine

protocol SortShipmentProtocolInput {
    func setShipmentId(shipmentId: Int?)
    func getShipmentCustomer()
    
    func didTapExpressCustomer(item: ShipmentCustomerItems?)
    func didTapDeleteCustomer(item: ShipmentCustomerItems?)
}

protocol SortShipmentProtocolOutput: class {
    var didGetShipmentCustomer: (() -> Void)? { get set }
    var didEditActionSuccess: ((ShipmentCustomerItems?) -> Void)? { get set }
    
    func getNumberOfCollectionCell() -> Int
    func getItemCollectionCell(index: Int) -> ShipmentCustomerItems?
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func getSizeItemViewCell() -> CGSize
    
    func getShipmentId() -> Int?
}

protocol SortShipmentProtocol: SortShipmentProtocolInput, SortShipmentProtocolOutput {
    var input: SortShipmentProtocolInput { get }
    var output: SortShipmentProtocolOutput { get }
}

class SortShipmentViewModel: SortShipmentProtocol, SortShipmentProtocolOutput {
    
    var input: SortShipmentProtocolInput { return self }
    var output: SortShipmentProtocolOutput { return self }
    
    // MARK: - Properties
    private var sortShipmentCollectionViewController: SortShipmentCollectionViewController
    // MARK: - UseCase
    private var getShipmentCustomerUseCase: GetShipmentCustomerUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(sortShipmentCollectionViewController: SortShipmentCollectionViewController,
         getShipmentCustomerUseCase: GetShipmentCustomerUseCase = GetShipmentCustomerUseCaseImpl()
    ) {
        self.sortShipmentCollectionViewController = sortShipmentCollectionViewController
        self.getShipmentCustomerUseCase = getShipmentCustomerUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetShipmentCustomer: (() -> Void)?
    var didEditActionSuccess: ((ShipmentCustomerItems?) -> Void)?
    
    private var listSortShipmentStock: [ShipmentCustomerItems]?
    private var shipmentId: Int?
    
    func setShipmentId(shipmentId: Int?) {
        self.shipmentId = shipmentId
    }
    
    func getShipmentId() -> Int? {
        return self.shipmentId
    }
    
    func getShipmentCustomer() {
        listSortShipmentStock?.removeAll()
        let item = SelectCustomerManager.shared.getSelectCustomer()
        self.listSortShipmentStock = item
        self.didGetShipmentCustomer?()
    }
    
    func getNumberOfCollectionCell() -> Int {
        guard let count = listSortShipmentStock?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemCollectionCell(index: Int) -> ShipmentCustomerItems? {
        guard let itemSortShipmentStock = listSortShipmentStock?[index] else { return nil }
        return itemSortShipmentStock
    }
    
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShipmentCustomerCollectionViewCell.identifier, for: indexPath) as! ShipmentCustomerCollectionViewCell
        cell.items = self.listSortShipmentStock?[indexPath.item]
        cell.delegate = self
        return cell
    }

    
    func getSizeItemViewCell() -> CGSize {
        let width = UIScreen.main.bounds.width / 4
        return CGSize(width: width, height: width)
    }
    
    func didTapExpressCustomer(item: ShipmentCustomerItems?) {
        listSortShipmentStock?.enumerated().forEach({ (index, itemBase) in
            if itemBase.customer?.cusId == item?.customer?.cusId {
                if let express = listSortShipmentStock?[index].express {
                    listSortShipmentStock?[index].express = !express
                }
            }
        })
        
        SelectCustomerManager.shared.setSelectCustomer(items: listSortShipmentStock ?? [])
        getShipmentCustomer()
    }
    
    func didTapDeleteCustomer(item: ShipmentCustomerItems?) {
        var indexDelete: Int?
        listSortShipmentStock?.enumerated().forEach({ (index, itemBase) in
            if itemBase.customer?.cusId == item?.customer?.cusId {
                indexDelete = index
            }
        })
        
        guard let index = indexDelete, let itemDelete = listSortShipmentStock?[index]   else { return }
        
        //Store  Delete
        var listDelete = SelectCustomerManager.shared.getListDeleteCustomer()
        listDelete.append(itemDelete)
        SelectCustomerManager.shared.setListDeleteCustomer(items: listDelete)
        
        listSortShipmentStock?.remove(at: index)
        //Store Add
        SelectCustomerManager.shared.setSelectCustomer(items: listSortShipmentStock ?? [])
        getShipmentCustomer()
    }
}

extension SortShipmentViewModel: ShipmentCustomerCollectionViewCellDelegate {
    func didEditAction(items: ShipmentCustomerItems?) {
        didEditActionSuccess?(items)
    }
}

