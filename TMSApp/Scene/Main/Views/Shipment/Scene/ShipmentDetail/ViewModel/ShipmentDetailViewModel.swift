//
//  ShipmentDetailViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/18/21.
//

import Foundation
import RxSwift
import UIKit

enum SectionShipment {
    case DeliveryCar
    case Employee
    case Customer
}

protocol ShipmentDetailProtocolInput {
    func getShipment()
}

protocol ShipmentDetailProtocolOutput: class {
    var didGetShipmentDetailSuccess: (() -> Void)? { get set }
    var didGetShipmentDetailError: (() -> Void)? { get set }
    
    func getSectionOfShipmentDetail() -> Int
    func getTypeSectionOfShipmentDetail(section: Int) -> SectionShipment
    func getTitleSectionOfShipmentDetail(section: Int) -> String
    func getNumberOfShipment(section: Int) -> Int
//    func getItemShipment(index: Int) -> GetShipmentResponse?
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getHeightTableViewCell(section: Int) -> CGFloat
    func getHeightSectionView() -> CGFloat
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
    private var shipmentDetailViewController: ShipmentDetailViewController
    
    fileprivate let disposeBag = DisposeBag()
    
    private var sections = [(name:String, type: SectionShipment)]()
    
    init(
//        getProductUseCase: GetProductUseCase = GetProductUseCaseImpl(),
        shipmentDetailViewController: ShipmentDetailViewController
    ) {
//        self.getProductUseCase = getProductUseCase
        self.shipmentDetailViewController = shipmentDetailViewController
        self.sections.append((name: "รถส่งสินค้า", type: SectionShipment.DeliveryCar))
        self.sections.append((name: "พนักงาน", type: SectionShipment.Employee))
        self.sections.append((name: "Customer", type: SectionShipment.Customer))
    }
    
    // MARK - Data-binding OutPut
    var didGetShipmentDetailSuccess: (() -> Void)?
    var didGetShipmentDetailError: (() -> Void)?
    
    fileprivate var listCar: [GetShipmentResponse]? = []
    fileprivate var listEmployee: [GetShipmentResponse]? = []
    fileprivate var listCustomer: [GetShipmentResponse]? = []
    
    func getShipment() {
        listCar?.removeAll()
        listCustomer?.removeAll()
        listEmployee?.removeAll()
        shipmentDetailViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.listCar?.append(GetShipmentResponse(title: "test"))
            weakSelf.listEmployee?.append(GetShipmentResponse(title: "test"))
            for _ in 0..<3 {
                weakSelf.listCustomer?.append(GetShipmentResponse(title: "test"))
                weakSelf.listCustomer?.append(GetShipmentResponse(title: "test"))
                weakSelf.listCustomer?.append(GetShipmentResponse(title: "test"))
            }

            weakSelf.didGetShipmentDetailSuccess?()
            weakSelf.shipmentDetailViewController.stopLoding()
        }
    }
    
    func getSectionOfShipmentDetail() -> Int {
        return self.sections.count
    }
    
    func getTypeSectionOfShipmentDetail(section: Int) -> SectionShipment {
        return self.sections[section].type
    }
    
    func getTitleSectionOfShipmentDetail(section: Int) -> String {
        return self.sections[section].name
    }
    
    func getNumberOfShipment(section: Int) -> Int {
        switch self.sections[section].type  {
        case .DeliveryCar:
            return listCar?.count ?? 0
        case .Employee:
            return listEmployee?.count ?? 0
        case .Customer:
            return listCustomer?.count ?? 0
        default:
            return 0
        }
    }
    
    func getItemShipment(index: Int) -> GetShipmentResponse? {
        guard let itemShipment = listCar?[index] else { return nil }
        return itemShipment
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch self.sections[indexPath.section].type  {
        case .DeliveryCar:
            let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryShipmentTableViewCell.identifier, for: indexPath) as! DeliveryShipmentTableViewCell
            cell.selectionStyle = .none
            cell.alpha = 0
            UIView.animate(withDuration: 0.3, animations: { cell.alpha = 1 })
            return cell
        case .Employee:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeShipmentTableViewCell.identifier, for: indexPath) as! EmployeeShipmentTableViewCell
            cell.selectionStyle = .none
            cell.alpha = 0
            UIView.animate(withDuration: 0.3, animations: { cell.alpha = 1 })
            return cell
        case .Customer:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomerShipmentTableViewCell.identifier, for: indexPath) as! CustomerShipmentTableViewCell
            cell.selectionStyle = .none
            cell.alpha = 0
            UIView.animate(withDuration: 0.3, animations: { cell.alpha = 1 })
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func getHeightTableViewCell(section: Int) -> CGFloat {
        switch self.sections[section].type  {
        case .DeliveryCar, .Employee:
            return 91
        case .Customer:
            return 109
        }
    }
    
    func getHeightSectionView() -> CGFloat {
        return 30
    }
}
