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
    func setShipmentId(shipmentId: String)
    func getSequenceShipment()
    func swapItem(sourceIndex: Int, destinationIndex: Int)
}

protocol SequenceShipmentProtocolOutput: class {
    var didGetSequenceShipmentSuccess: (() -> Void)? { get set }
    var didGetSequenceShipmentError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
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
    private var shipmentId: String?
    
    func setShipmentId(shipmentId: String) {
        self.shipmentId = shipmentId
    }
    
    func getSequenceShipment() {
        listSequenceShipment?.removeAll()
        sequenceShipmentViewController.startLoding()
        guard let shipmentId = self.shipmentId else { return }
        self.getShipmentCustomerUseCase.execute(shipmentId: shipmentId).sink { completion in
            debugPrint("ShipmentCustomer \(completion)")
        } receiveValue: { resp in
            if let items = resp?.data?.shipmentCustomer {
                self.listSequenceShipment = items
            }
            self.didGetSequenceShipmentSuccess?()
            self.sequenceShipmentViewController.stopLoding()
        }.store(in: &self.anyCancellable)
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listSequenceShipment?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SequenceShipmentTableViewCell.identifier, for: indexPath) as! SequenceShipmentTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func swapItem(sourceIndex: Int, destinationIndex: Int) {
        self.listSequenceShipment?.swapAt(sourceIndex, destinationIndex)
    }
}
