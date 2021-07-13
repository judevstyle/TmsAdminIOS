//
//  ShipmentDetailCellViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/13/21.
//

import Foundation
import UIKit

protocol ShipmentDetailProtocolInput {
    func setShipment(item: ShipmentItems)
}

protocol ShipmentDetailProtocolOutput: class {
    var didGetShipmentDetailSuccess: (() -> Void)? { get set }
    var didGetShipmentDetailError: (() -> Void)? { get set }
    
    func getCodeShipment() -> String
    func getCountCustomer() -> String
    func getCarInfo() -> String
    func getPlanName() -> String
    func getSummaryCustomer() -> SummaryCustomer?
}

protocol ShipmentDetailProtocol: ShipmentDetailProtocolInput, ShipmentDetailProtocolOutput {
    var input: ShipmentDetailProtocolInput { get }
    var output: ShipmentDetailProtocolOutput { get }
}

class ShipmentDetailViewModel: ShipmentDetailProtocol, ShipmentDetailProtocolOutput {
    
    var input: ShipmentDetailProtocolInput { return self }
    var output: ShipmentDetailProtocolOutput { return self }
    
    // MARK: - Properties
    //    private var getProductUseCase: GetProductUseCase
    private var shipmentDetailViewCell: ShipmentDetailViewCell
    
    init(
        //        getProductUseCase: GetProductUseCase = GetProductUseCaseImpl(),
        shipmentDetailViewCell: ShipmentDetailViewCell
    ) {
        //        self.getProductUseCase = getProductUseCase
        self.shipmentDetailViewCell = shipmentDetailViewCell
    }
    
    // MARK - Data-binding OutPut
    var didGetShipmentDetailSuccess: (() -> Void)?
    var didGetShipmentDetailError: (() -> Void)?
    
    fileprivate var listCar: [GetShipmentResponse]? = []
    fileprivate var listEmployee: [GetShipmentResponse]? = []
    fileprivate var listCustomer: [GetShipmentResponse]? = []
    
    private var shipmentItem: ShipmentItems?
    
    func setShipment(item: ShipmentItems) {
        self.shipmentItem = item
        self.didGetShipmentDetailSuccess?()
    }
    
}

extension ShipmentDetailViewModel {
    @objc func dismissAlertController() {
//        shipmentDetailViewController.dismiss(animated: true, completion: nil)
    }
}

//MARK:- OUTPUT
extension ShipmentDetailViewModel {
    
    func getPlanName() -> String {
        guard let planName = self.shipmentItem?.planName else { return "" }
        return planName
    }
    func getCodeShipment() -> String {
        guard let shipmentNo = self.shipmentItem?.shipmentNo else { return "" }
        return shipmentNo
    }
    
    func getCountCustomer() -> String {
        guard let shipmentNo = self.shipmentItem?.customerShipmentNumber?.totalCustomer else { return "0" }
        return "\(shipmentNo)"
    }
    
    func getCarInfo() -> String {
        guard let truck = self.shipmentItem?.truckRegistrationNumber else { return "" }
        return truck
    }
    
    func getSummaryCustomer() -> SummaryCustomer? {
        guard let summary = self.shipmentItem?.customerShipmentNumber else { return nil }
        return summary
    }
}
