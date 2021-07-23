//
//  SortSortShipmentViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import Foundation
import UIKit
import Combine

public protocol SortShipmentViewModelDelegate {
    func didUpdateShipmentSuccess()
}

protocol SortShipmentProtocolInput {
    func setItemShipment(items: ShipmentItems?)
    func getShipmentCustomer()
    
    func didTapExpressCustomer(item: ShipmentCustomerItems?)
    func didTapDeleteCustomer(item: ShipmentCustomerItems?)
    
    func moveItemAt(_ collectionView: UICollectionView, sourceIndexPath: IndexPath, destinationIndexPath: IndexPath)
    
    func saveShipmentCustomer()
    
    func setDelegate(delegate: SortShipmentViewModelDelegate?)
}

protocol SortShipmentProtocolOutput: class {
    var didGetShipmentCustomer: (() -> Void)? { get set }
    var didEditActionSuccess: ((ShipmentCustomerItems?) -> Void)? { get set }
    
    func getNumberOfCollectionCell() -> Int
    func getItemCollectionCell(index: Int) -> ShipmentCustomerItems?
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func getSizeItemViewCell() -> CGSize
    
    func getShipmentItem() -> ShipmentItems?
}

protocol SortShipmentProtocol: SortShipmentProtocolInput, SortShipmentProtocolOutput {
    var input: SortShipmentProtocolInput { get }
    var output: SortShipmentProtocolOutput { get }
}

class SortShipmentViewModel: SortShipmentProtocol, SortShipmentProtocolOutput {

    var input: SortShipmentProtocolInput { return self }
    var output: SortShipmentProtocolOutput { return self }
    
    public var delegate: SortShipmentViewModelDelegate?
    
    // MARK: - Properties
    private var sortShipmentCollectionViewController: SortShipmentCollectionViewController
    // MARK: - UseCase
    private var putShipmentUseCase: PutShipmentUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(sortShipmentCollectionViewController: SortShipmentCollectionViewController,
         putShipmentUseCase: PutShipmentUseCase = PutShipmentUseCaseImpl()
    ) {
        self.sortShipmentCollectionViewController = sortShipmentCollectionViewController
        self.putShipmentUseCase = putShipmentUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetShipmentCustomer: (() -> Void)?
    var didEditActionSuccess: ((ShipmentCustomerItems?) -> Void)?
    
    private var listSortShipmentStock: [ShipmentCustomerItems]?
    private var shipmentItem: ShipmentItems?
    
    func setItemShipment(items: ShipmentItems?) {
        self.shipmentItem = items
    }
    
    func setDelegate(delegate: SortShipmentViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func getShipmentItem() -> ShipmentItems? {
        return self.shipmentItem
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
    
    
    func moveItemAt(_ collectionView: UICollectionView, sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        if let item = self.listSortShipmentStock?.remove(at: sourceIndexPath.row) {
            self.listSortShipmentStock?.insert(item, at: destinationIndexPath.row)
            SelectCustomerManager.shared.setSelectCustomer(items: self.listSortShipmentStock ?? [])
        }
    }
    
    func saveShipmentCustomer() {
        let shipmentCustomer = SelectCustomerManager.shared.getSelectCustomer()
        let shipmentDeleteCustomer = SelectCustomerManager.shared.getListDeleteCustomer()
        
        guard let item = self.shipmentItem,
              let shipmentId = item.shipmentId,
              let planId = item.planId,
              let status = item.status
              else { return }
        var request: PutShipmentRequest = PutShipmentRequest()
        request.planId = planId
        request.status = status
        request.shipmentStock = []
        
        var listRequest: [ShipmentCustomerRequest] = []
        shipmentCustomer.enumerated().forEach({ (index, item) in
            var requestCustomer: ShipmentCustomerRequest = ShipmentCustomerRequest()
            requestCustomer.shipmentCusId = item.shipmentCusId
            requestCustomer.seq = item.seq
            requestCustomer.cusId = item.customer?.cusId
            requestCustomer.statusSend = item.statusSend ?? 1
            requestCustomer.statusSendRemark = item.statusSendRemark ?? ""
            requestCustomer.express = item.express ?? false
            requestCustomer.del = 0
            listRequest.append(requestCustomer)
        })
        
        shipmentDeleteCustomer.enumerated().forEach({(index, item) in
            if let shipmentCusId = item.shipmentCusId {
                var requestDeleteCustomer: ShipmentCustomerRequest = ShipmentCustomerRequest()
                requestDeleteCustomer.shipmentCusId = shipmentCusId
                requestDeleteCustomer.seq = item.seq
                requestDeleteCustomer.cusId = item.customer?.cusId
                requestDeleteCustomer.statusSend = item.statusSend ?? 1
                requestDeleteCustomer.statusSendRemark = item.statusSendRemark ?? ""
                requestDeleteCustomer.express = item.express ?? false
                requestDeleteCustomer.del = 1
                listRequest.append(requestDeleteCustomer)
            }
        })

        request.shipmentCustomer = listRequest
    
        self.sortShipmentCollectionViewController.startLoding()
        self.putShipmentUseCase.execute(shipmentId: shipmentId, request: request).sink { completion in
            debugPrint("putShipment \(completion)")
            self.sortShipmentCollectionViewController.stopLoding()
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "PutShipment finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "PutShipment failure")
                break
            }
            
        } receiveValue: { resp in
            debugPrint(resp.success)
            if resp.success == true {
                self.delegate?.didUpdateShipmentSuccess()
                self.sortShipmentCollectionViewController.navigationController?.popViewController(animated: true)
            }
        }.store(in: &self.anyCancellable)
    }
}

extension SortShipmentViewModel: ShipmentCustomerCollectionViewCellDelegate {
    func didEditAction(items: ShipmentCustomerItems?) {
        didEditActionSuccess?(items)
    }
}
