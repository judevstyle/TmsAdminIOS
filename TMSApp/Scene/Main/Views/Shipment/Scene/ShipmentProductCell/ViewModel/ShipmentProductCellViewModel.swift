//
//  ShipmentProductCellViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import Foundation
import UIKit
import Combine

protocol ShipmentProductCellProtocolInput {
    func getShipmentStock(shipmentId: Int?)
    func didSelectItemAt(_ collectionView: UICollectionView, indexPath: IndexPath)
}

protocol ShipmentProductCellProtocolOutput: class {
    var didGetShipmentStockSuccess: (() -> Void)? { get set }
    
    func getNumberOfCollectionCell() -> Int
    func getItemShipmentProductCell(index: Int) -> ShipmentStockItems?
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func getItemViewCellHeight() -> CGFloat
    func getSizeItemViewCell() -> CGSize
    
    func getShipmentId() -> Int?
}

protocol ShipmentProductCellProtocol: ShipmentProductCellProtocolInput, ShipmentProductCellProtocolOutput {
    var input: ShipmentProductCellProtocolInput { get }
    var output: ShipmentProductCellProtocolOutput { get }
}

class ShipmentProductCellViewModel: ShipmentProductCellProtocol, ShipmentProductCellProtocolOutput {
    var input: ShipmentProductCellProtocolInput { return self }
    var output: ShipmentProductCellProtocolOutput { return self }
    
    // MARK: - Properties
    private var shipmentProductCell: ShipmentProductCell
    // MARK: - UseCase
    private var getShipmentStockUseCase: GetShipmentStockUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(shipmentProductCell: ShipmentProductCell,
         getShipmentStockUseCase: GetShipmentStockUseCase = GetShipmentStockUseCaseImpl()
    ) {
        self.shipmentProductCell = shipmentProductCell
        self.getShipmentStockUseCase = getShipmentStockUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetShipmentStockSuccess: (() -> Void)?
    
    private var litShipmentStock: [ShipmentStockItems]?
    fileprivate var shipmentId: Int?
    
    func getShipmentStock(shipmentId: Int?) {
        self.shipmentId = shipmentId
        litShipmentStock?.removeAll()
        var request: GetShipmentStockRequest = GetShipmentStockRequest()
        request.shipmentId = shipmentId
        self.getShipmentStockUseCase.execute(request: request).sink { completion in
            debugPrint("getShipmentStock \(completion)")
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetShipmentStock finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "GetShipmentStock failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp {
                self.litShipmentStock = items
                self.didGetShipmentStockSuccess?()
            }
        }.store(in: &self.anyCancellable)
    }
    
    func getNumberOfCollectionCell() -> Int {
        guard let count = litShipmentStock?.count, count != 0 else { return 0 }
        return count
    }
    
    func getShipmentId() -> Int? {
        return self.shipmentId
    }
    
    func getItemShipmentProductCell(index: Int) -> ShipmentStockItems? {
        guard let itemShipmentStock = litShipmentStock?[index] else { return nil }
        return itemShipmentStock
    }
    
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        cell.itemsShipmentStock = self.litShipmentStock?[indexPath.item]
        return cell
    }
    
    func getItemViewCellHeight() -> CGFloat {
        return 13
    }
    
    func getSizeItemViewCell() -> CGSize {
        let width = UIScreen.main.bounds.width / 4
        return CGSize(width: width, height: width)
    }
    
    func didSelectItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) {
        guard let itemShipmentStock = getItemShipmentProductCell(index: indexPath.row)  else { return }
        NavigationManager.instance.pushVC(to: .productDetailQty(shipmentId: itemShipmentStock.shipmentId, itemProduct: itemShipmentStock.product, typeAction: .remove, delegate: self, qty: itemShipmentStock.qty), presentation: .BottomSheet(completion: {
                                            }, height: 588))
    }
}


extension ShipmentProductCellViewModel: ProductDetailQtyViewModelDelegate {
    func didConfirmQtyProductComplete() {
        debugPrint("OK")
    }
}
