//
//  ShipmentViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/15/21.
//

import Foundation
import RxSwift
import UIKit

protocol ShipmentProtocolInput {
    func getShipment(request: GetShipmentRequest)
}

protocol ShipmentProtocolOutput: class {
    var didGetShipmentSuccess: (() -> Void)? { get set }
    var didGetShipmentError: (() -> Void)? { get set }
    
    func getNumberOfShipment() -> Int
    func getItemShipment(index: Int) -> GetShipmentResponse?
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
//    private var getProductUseCase: GetProductUseCase
    private var shipmentViewController: ShipmentViewController
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
//        getProductUseCase: GetProductUseCase = GetProductUseCaseImpl(),
        shipmentViewController: ShipmentViewController
    ) {
//        self.getProductUseCase = getProductUseCase
        self.shipmentViewController = shipmentViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetShipmentSuccess: (() -> Void)?
    var didGetShipmentError: (() -> Void)?
    
    fileprivate var listShipment: [GetShipmentResponse]? = []
    
    func getShipment(request: GetShipmentRequest) {
        listShipment?.removeAll()
        shipmentViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<3 {
                weakSelf.listShipment?.append(GetShipmentResponse(title: "test"))
            }

            weakSelf.didGetShipmentSuccess?()
            weakSelf.shipmentViewController.stopLoding()
        }
    }
    
    func getNumberOfShipment() -> Int {
        guard let count = listShipment?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemShipment(index: Int) -> GetShipmentResponse? {
        guard let itemShipment = listShipment?[index] else { return nil }
        return itemShipment
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShipmentTableViewCell.identifier, for: indexPath) as! ShipmentTableViewCell
        cell.selectionStyle = .none
        cell.setData(item: getItemShipment(index: indexPath.item))
        return cell
    }
    
    func getItemViewCellHeight() -> CGFloat {
        return 174
    }
}
