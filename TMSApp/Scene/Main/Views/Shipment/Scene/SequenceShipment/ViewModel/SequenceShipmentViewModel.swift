//
//  SequenceShipmentViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import Foundation
import UIKit
import Combine

protocol SequenceShipmentProtocolInput {
    func setItemShipment(items: ShipmentItems?)
    func getSequenceShipment()
    func swapItem(sourceIndex: Int, destinationIndex: Int)
}

protocol SequenceShipmentProtocolOutput: class {
    var didGetSequenceShipmentSuccess: (() -> Void)? { get set }
    var didGetSequenceShipmentError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
    func getShipmentItem() -> ShipmentItems?
}

protocol SequenceShipmentProtocol: SequenceShipmentProtocolInput, SequenceShipmentProtocolOutput {
    var input: SequenceShipmentProtocolInput { get }
    var output: SequenceShipmentProtocolOutput { get }
}

class SequenceShipmentViewModel: SequenceShipmentProtocol, SequenceShipmentProtocolOutput {
    
    var input: SequenceShipmentProtocolInput { return self }
    var output: SequenceShipmentProtocolOutput { return self }
    
    // MARK: - Properties
    private var sequenceShipmentViewController: SequenceShipmentViewController
    
    private var getShipmentCustomerUseCase: GetShipmentCustomerUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    init(
        sequenceShipmentViewController: SequenceShipmentViewController,
        getShipmentCustomerUseCase: GetShipmentCustomerUseCase = GetShipmentCustomerUseCaseImpl()
    ) {
        self.sequenceShipmentViewController = sequenceShipmentViewController
        self.getShipmentCustomerUseCase = getShipmentCustomerUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetSequenceShipmentSuccess: (() -> Void)?
    var didGetSequenceShipmentError: (() -> Void)?
    
    fileprivate var listSequenceShipment: [ShipmentCustomerItems]? = []
    
    private var shipmentItem: ShipmentItems?
    
    func setItemShipment(items: ShipmentItems?) {
        self.shipmentItem = items
    }
    
    func getShipmentItem() -> ShipmentItems? {
        return self.shipmentItem
    }
    
    func getSequenceShipment() {
        listSequenceShipment?.removeAll()
        sequenceShipmentViewController.startLoding()
        guard let shipmentId = self.shipmentItem?.shipmentId else { return }
        debugPrint("shipmentId \(shipmentId)")
        self.getShipmentCustomerUseCase.execute(shipmentId: shipmentId).sink { completion in
            debugPrint("getShipmentCustomer \(completion)")
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetShipmentCustomer finished")
                break
            case .failure(_):
                SelectCustomerManager.shared.setSelectCustomer(items: [])
                SelectCustomerManager.shared.setListDeleteCustomer(items: [])
                ToastManager.shared.toastCallAPI(title: "GetShipmentCustomer failure")
                break
            }
            
            self.sequenceShipmentViewController.stopLoding()
        } receiveValue: { resp in
            
            if let items = resp?.data {
                self.listSequenceShipment = items
                SelectCustomerManager.shared.setSelectCustomer(items: self.listSequenceShipment ?? [])
                SelectCustomerManager.shared.setListDeleteCustomer(items: [])
            } else {
                SelectCustomerManager.shared.setSelectCustomer(items: [])
                SelectCustomerManager.shared.setListDeleteCustomer(items: [])
            }
            self.didGetSequenceShipmentSuccess?()
        }.store(in: &self.anyCancellable)
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listSequenceShipment?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SequenceShipmentTableViewCell.identifier, for: indexPath) as! SequenceShipmentTableViewCell
        cell.selectionStyle = .none
        cell.items = self.listSequenceShipment?[indexPath.item]
        return cell
    }
    
    func swapItem(sourceIndex: Int, destinationIndex: Int) {
        self.listSequenceShipment?.swapAt(sourceIndex, destinationIndex)
    }
}
