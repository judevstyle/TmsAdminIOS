//
//  ShipmentDetailViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/18/21.
//

import Foundation
import UIKit

enum SectionShipment {
    case DeliveryCar
    case Employee
    case Customer
}

protocol ShipmentDetailProtocolInput {
    func setShipment(item: ShipmentItems)
    func getShipment()
    func didSelectRowAt(_ tableView: UITableView, indexPath: IndexPath)
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
    private var shipmentDetailViewController: ShipmentDetailViewController
    
    
    
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
    
    private var shipmentItem: ShipmentItems?
    
    func setShipment(item: ShipmentItems) {
        self.shipmentItem = item
    }
    
    func getShipment() {
        self.didGetShipmentDetailSuccess?()
    }
    
    func didSelectRowAt(_ tableView: UITableView, indexPath: IndexPath) {
        switch self.sections[indexPath.section].type {
        case .DeliveryCar:
            print("didSelectRowAt \(SectionShipment.DeliveryCar)")
        case .Employee:
            print("didSelectRowAt \(SectionShipment.Employee)")
        case .Customer:
            let alertController = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
            let customView = CustomerSettingView(frame: CGRect(x: 0, y: 0, width: alertController.view.bounds.width-16, height: 166))
            customView.delegate = self
            
            alertController.view.addSubview(customView)
            alertController.view.backgroundColor = .white
            alertController.view.layer.cornerRadius = 8
            alertController.view.layer.masksToBounds = true
            
            alertController.view.translatesAutoresizingMaskIntoConstraints = false
            alertController.view.heightAnchor.constraint(equalToConstant: customView.frame.height).isActive = true
            
            customView.backgroundColor = .green
            
            shipmentDetailViewController.present(alertController, animated: true) {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                alertController.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
            }
        }
    }
}


extension ShipmentDetailViewModel: CustomerSettingViewDelegate {
    func didSelectSettingRowAt(_ tableView: UITableView, indexPath: IndexPath) {
        shipmentDetailViewController.dismiss(animated: true, completion: nil)
    }
}

extension ShipmentDetailViewModel {
    @objc func dismissAlertController() {
        shipmentDetailViewController.dismiss(animated: true, completion: nil)
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
        return "0"
    }
    
    func getCarInfo() -> String {
        guard let truck = self.shipmentItem?.truckRegistrationNumber else { return "" }
        return truck
    }
    
    func getSummaryCustomer() -> SummaryCustomer? {
        guard let summary = self.shipmentItem?.customerShipmentNumber else { return nil }
        return summary
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
