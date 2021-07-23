//
//  SelectCustomerViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import Foundation
import UIKit
import Combine

protocol SelectCustomerProtocolInput {
    func setShipmentId(shipmentId: Int?)
    func getSelectCustomer()
    func didSelectItemAtRow(_ tableView: UITableView, indexPath: IndexPath)
}

protocol SelectCustomerProtocolOutput: class {
    var didGetSelectCustomerSuccess: (() -> Void)? { get set }
    var didGetSelectCustomerError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
    func getShipmentId() -> Int?
}

protocol SelectCustomerProtocol: SelectCustomerProtocolInput, SelectCustomerProtocolOutput {
    var input: SelectCustomerProtocolInput { get }
    var output: SelectCustomerProtocolOutput { get }
}

class SelectCustomerViewModel: SelectCustomerProtocol, SelectCustomerProtocolOutput {
    
    var input: SelectCustomerProtocolInput { return self }
    var output: SelectCustomerProtocolOutput { return self }
    
    // MARK: - Properties
    private var selectCustomerViewController: SelectCustomerViewController
    
    private var getCustomerSenderMatchingUseCase: GetCustomerSenderMatchingUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    init(
        selectCustomerViewController: SelectCustomerViewController,
        getShipmentCustomerUseCase: GetCustomerSenderMatchingUseCase = GetCustomerSenderMatchingUseCaseImpl()
    ) {
        self.selectCustomerViewController = selectCustomerViewController
        self.getCustomerSenderMatchingUseCase = getShipmentCustomerUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetSelectCustomerSuccess: (() -> Void)?
    var didGetSelectCustomerError: (() -> Void)?
    
    fileprivate var listAllCustomer: [CustomerItems]? = []
    fileprivate var listCompareCustomer: [CustomerItems]? = []
    
    private var shipmentId: Int?
    
    func setShipmentId(shipmentId: Int?) {
        self.shipmentId = shipmentId
    }
    
    func getShipmentId() -> Int? {
        return self.shipmentId
    }
    
    func getSelectCustomer() {
        listAllCustomer?.removeAll()
        selectCustomerViewController.startLoding()
        guard let shipmentId = self.shipmentId else { return }
        var request: GetCustomerSenderMatchingRequest = GetCustomerSenderMatchingRequest()
        request.shipmentId = shipmentId
        request.limit = 50
        request.page = 1
        self.getCustomerSenderMatchingUseCase.execute(request: request).sink { completion in
            debugPrint("getCustomerSenderMatching \(completion)")
            self.selectCustomerViewController.stopLoding()
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetCustomerSenderMatching finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "GetCustomerSenderMatching failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp?.items {
                self.listAllCustomer = items
                self.compareCustomer()
            }
        }.store(in: &self.anyCancellable)
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listCompareCustomer?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SequenceShipmentTableViewCell.identifier, for: indexPath) as! SequenceShipmentTableViewCell
        cell.selectionStyle = .none
        cell.itemsCustomer = self.listCompareCustomer?[indexPath.item]
        return cell
    }
    
    private func compareCustomer() {
        self.listCompareCustomer?.removeAll()
        let listSelect = SelectCustomerManager.shared.getSelectCustomer()
        let listDelete = SelectCustomerManager.shared.getListDeleteCustomer()
        var listCompare: [CustomerItems]? = []
        
        //Delete
        listDelete.forEach({ itemDelete in
            var isMatch: Bool = false
            
            self.listAllCustomer?.forEach({ item in
                if itemDelete.customer?.cusId == item.cusId {
                    isMatch = true
                }
            })
            
            if let customer = itemDelete.customer, isMatch == false {
                listCompare?.append(customer)
            }
        })
        
        //Select
        self.listAllCustomer?.forEach({ item in
            var isMatch: Bool = false
            listSelect.forEach({itemSelect in
                if itemSelect.customer?.cusId == item.cusId {
                    isMatch = true
                }
            })
            if isMatch == false {
                listCompare?.append(item)
            }
        })
        
        self.listCompareCustomer = listCompare
        
        self.didGetSelectCustomerSuccess?()
    }
    
    func didSelectItemAtRow(_ tableView: UITableView, indexPath: IndexPath) {
        guard let item = self.listCompareCustomer?[indexPath.item] else { return }
        
        var listSelect = SelectCustomerManager.shared.getSelectCustomer()
        var listDelete = SelectCustomerManager.shared.getListDeleteCustomer()
        
        var itemMatchDelete: ShipmentCustomerItems?
        var indexMatchDelete: Int?
        
        listDelete.enumerated().forEach({ (index, itemDelete) in
            if item.cusId == itemDelete.customer?.cusId {
                itemMatchDelete = itemDelete
                indexMatchDelete = index
            }
        })
        
        if var itemRequest = itemMatchDelete, let index = indexMatchDelete  {
            listDelete.remove(at: index)
            itemRequest.express = false
            listSelect.append(itemRequest)
        } else {
            var requestSelect: ShipmentCustomerItems = ShipmentCustomerItems()
            requestSelect.cusId = item.cusId
            requestSelect.express = false
            requestSelect.customer = item
            listSelect.append(requestSelect)
        }
        
        SelectCustomerManager.shared.setListDeleteCustomer(items: listDelete)
        SelectCustomerManager.shared.setSelectCustomer(items: listSelect)
    
        compareCustomer()

    }

}
