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
            self.shipmentViewController.stopLoding()
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetShipment finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "GetShipment failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp?.data?.items {
                self.listShipment = items
            }
            self.didGetShipmentSuccess?()
            self.shipmentViewController.stopLoding()
        }.store(in: &self.anyCancellable)
    }
    
    func getNumberOfShipment() -> Int {
        guard let count = listShipment?.count, count != 0 else { return 1 }
        return count
    }
    
    func getItemShipment(index: Int) -> ShipmentItems? {
        guard let itemShipment = listShipment?[index] else { return nil }
        return itemShipment
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if listShipment?.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as! EmptyTableViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ShipmentTableViewCell.identifier, for: indexPath) as! ShipmentTableViewCell
            cell.selectionStyle = .none
            cell.items = self.listShipment?[indexPath.item]
            return cell
        }
    }
    
    func getItemViewCellHeight() -> CGFloat {
        if listShipment?.count == 0  {
            return 50
        } else {
            return UITableView.automaticDimension
        }
    }
}
