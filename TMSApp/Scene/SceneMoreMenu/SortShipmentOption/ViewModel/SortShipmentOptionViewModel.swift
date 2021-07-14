//
//  SortShipmentOptionViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/15/21.
//

import Foundation
import UIKit
import Combine

public protocol SortShipmentOptionViewModelDelegate {
    func didTapFastExpress(item: ShipmentCustomerItems?)
    func didDeleteCustomer(item: ShipmentCustomerItems?)
}

protocol SortShipmentOptionProtocolInput {
    func didExpress()
    func didDelete()
    func setDelegate(delegate: SortShipmentOptionViewModelDelegate)
    func setItem(item: ShipmentCustomerItems?)
}

protocol SortShipmentOptionProtocolOutput: class {

}

protocol SortShipmentOptionProtocol: SortShipmentOptionProtocolInput, SortShipmentOptionProtocolOutput {
    var input: SortShipmentOptionProtocolInput { get }
    var output: SortShipmentOptionProtocolOutput { get }
}

class SortShipmentOptionViewModel: SortShipmentOptionProtocol, SortShipmentOptionProtocolOutput {
    
    var input: SortShipmentOptionProtocolInput { return self }
    var output: SortShipmentOptionProtocolOutput { return self }
    
    // MARK: - Properties
    private var sortShipmentOptionViewController: SortShipmentOptionViewController
    
    // MARK: - UseCase
    
    public var delegate: SortShipmentOptionViewModelDelegate?
    public var item: ShipmentCustomerItems?
    
    init(
        sortShipmentOptionViewController: SortShipmentOptionViewController
    ) {
        self.sortShipmentOptionViewController = sortShipmentOptionViewController
    }

    func didExpress() {
        self.delegate?.didTapFastExpress(item: self.item)
        self.sortShipmentOptionViewController.dismiss(animated: true, completion: nil)
    }
    
    func didDelete() {
        self.delegate?.didDeleteCustomer(item: self.item)
        self.sortShipmentOptionViewController.dismiss(animated: true, completion: nil)
    }
    
    func setDelegate(delegate: SortShipmentOptionViewModelDelegate) {
        self.delegate = delegate
    }
    
    func setItem(item: ShipmentCustomerItems?) {
        self.item = item
    }
}
