//
//  ShipmentFlowLayoutFlowLayoutViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/13/21.
//

import Foundation
import UIKit
import Combine

protocol ShipmentFlowLayoutProtocolInput {
    func setShipment(item: ShipmentItems)
}

protocol ShipmentFlowLayoutProtocolOutput: class {
    
    func getCellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func getNumberOfItemsInSection(_ collectionView: UICollectionView, section: Int) -> Int
    
    func getItemShipment() -> ShipmentItems?
}

protocol ShipmentFlowLayoutProtocol: ShipmentFlowLayoutProtocolInput, ShipmentFlowLayoutProtocolOutput {
    var input: ShipmentFlowLayoutProtocolInput { get }
    var output: ShipmentFlowLayoutProtocolOutput { get }
}

class ShipmentFlowLayoutViewModel: ShipmentFlowLayoutProtocol, ShipmentFlowLayoutProtocolOutput {
    var input: ShipmentFlowLayoutProtocolInput { return self }
    var output: ShipmentFlowLayoutProtocolOutput { return self }
    
    // MARK: - Properties
    private var shipmentFlowLayoutViewController: ShipmentFlowLayoutViewController
    
    init(
        shipmentFlowLayoutViewController: ShipmentFlowLayoutViewController
    ) {
        self.shipmentFlowLayoutViewController = shipmentFlowLayoutViewController
    }
    
    private var shipmentItem: ShipmentItems?
    // MARK - Data-binding OutPut
    
    func setShipment(item: ShipmentItems) {
        self.shipmentItem = item
    }
    
    func getCellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShipmentDetailViewCell.identifier, for: indexPath) as! ShipmentDetailViewCell
            if let shipmentItem  = self.shipmentItem  {
                cell.viewModel.input.setShipment(item: shipmentItem)
            }
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShipmentProductCell.identifier, for: indexPath) as! ShipmentProductCell
            if let shipmentId = self.shipmentItem?.shipmentId {
                cell.viewModel.input.getShipmentStock(shipmentId: shipmentId)
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func getItemShipment() -> ShipmentItems? {
        return self.shipmentItem
    }
    
    func getNumberOfItemsInSection(_ collectionView: UICollectionView, section: Int) -> Int {
        return 2
    }
}
