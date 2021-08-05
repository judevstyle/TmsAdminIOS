//
//  ProductShipmentViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/4/21.
//

import Foundation
import UIKit
import Combine

protocol ProductShipmentProtocolInput {
    func setShipmentCustomer(item: ShipmentCustomerItems?)
}

protocol ProductShipmentProtocolOutput: class {
    
    func getCellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func getNumberOfItemsInSection(_ collectionView: UICollectionView, section: Int) -> Int
    
    func getItemShipmentCustomer() -> ShipmentCustomerItems?
}

protocol ProductShipmentProtocol: ProductShipmentProtocolInput, ProductShipmentProtocolOutput {
    var input: ProductShipmentProtocolInput { get }
    var output: ProductShipmentProtocolOutput { get }
}

class ProductShipmentViewModel: ProductShipmentProtocol, ProductShipmentProtocolOutput {
    var input: ProductShipmentProtocolInput { return self }
    var output: ProductShipmentProtocolOutput { return self }
    
    // MARK: - Properties
    private var productShipmentViewController: ProductShipmentViewController
    
    init(
        productShipmentViewController: ProductShipmentViewController
    ) {
        self.productShipmentViewController = productShipmentViewController
    }
    
    private var shipmentCustomer: ShipmentCustomerItems?
    // MARK - Data-binding OutPut
    
    func setShipmentCustomer(item: ShipmentCustomerItems?) {
        self.shipmentCustomer = item
    }
    
    func getCellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BillNowCollectionViewCell.identifier, for: indexPath) as! BillNowCollectionViewCell
            cell.viewModel.input.setShipmentCustomerItems(item: self.shipmentCustomer)
            cell.viewModel.input.getOrder()
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BillPaymentCollectionViewCell.identifier, for: indexPath) as! BillPaymentCollectionViewCell
            cell.viewModel.input.setShipmentCustomerItems(item: self.shipmentCustomer)
            cell.viewModel.input.getOrder()
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func getItemShipmentCustomer() -> ShipmentCustomerItems? {
        return self.shipmentCustomer
    }
    
    func getNumberOfItemsInSection(_ collectionView: UICollectionView, section: Int) -> Int {
        return 2
    }
}
