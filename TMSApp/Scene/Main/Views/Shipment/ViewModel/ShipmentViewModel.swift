//
//  ShipmentViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/15/21.
//

import Foundation
import UIKit
import Combine

protocol ShipmentProtocolInput {
    func getShipment()
}

protocol ShipmentProtocolOutput: class {
    var didGetShipmentSuccess: (() -> Void)? { get set }
    var didGetShipmentError: (() -> Void)? { get set }
    
    func getNumberOfShipment() -> Int
    func getItemShipment(index: Int) -> ShipmentItems?
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemViewCellHeight() -> CGFloat
}

protocol ShipmentProtocol: ShipmentProtocolInput, ShipmentProtocolOutput {
    var input: ShipmentProtocolInput { get }
    var output: ShipmentProtocolOutput { get }
}

class ShipmentViewModel: ShipmentProtocol, ShipmentProtocolOutput {
    var input: ShipmentProtocolInput { return self }
    var output: ShipmentProtocolOutput { return self }
    
    // MARK: - Properties
    private var getShipmentUseCase: GetShipmentUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    private var shipmentViewController: ShipmentViewController
    
    
    
    init(
        shipmentViewController: ShipmentViewController,
        getShipmentUseCase: GetShipmentUseCase = GetShipmentUseCaseImpl()
    ) {
        self.shipmentViewController = shipmentViewController
        self.getShipmentUseCase = getShipmentUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetShipmentSuccess: (() -> Void)?
    var didGetShipmentError: (() -> Void)?
    
    fileprivate var listShipment: [ShipmentItems]?
    
    func getShipment() {
        listShipment?.removeAll()
        shipmentViewController.startLoding()
        
        self.getShipmentUseCase.execute().sink { completion in
            debugPrint("getShipment \(completion)")
        } receiveValue: { resp in
            if let items = resp?.data?.items {
                self.listShipment = items
            }
            self.didGetShipmentSuccess?()
            self.shipmentViewController.stopLoding()
        }.store(in: &self.anyCancellable)
    }
    
    func getNumberOfShipment() -> Int {
        guard let count = listShipment?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemShipment(index: Int) -> ShipmentItems? {
        guard let itemShipment = listShipment?[index] else { return nil }
        return itemShipment
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShipmentTableViewCell.identifier, for: indexPath) as! ShipmentTableViewCell
        cell.selectionStyle = .none
        cell.items = self.listShipment?[indexPath.item]
        return cell
    }
    
    func getItemViewCellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
}
