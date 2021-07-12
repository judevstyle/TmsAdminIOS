//
//  EditEditPlanMasterViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import Foundation
import UIKit
import Combine

protocol EditPlanMasterProtocolInput {
    func getPlanMasterDetail()
    func getEmployee()
    func getShop()
    func getTruck()
    func setEdit(isEdit: Bool)
    func setPlanId(planId: Int?)
}

protocol EditPlanMasterProtocolOutput: class {
    var didGetPlanMasterDetailSuccess: (() -> Void)? { get set }
    var didGetEmployeeSuccess: (() -> Void)? { get set }
    var didGetShopSuccess: (() -> Void)? { get set }
    var didGetTruckSuccess: (() -> Void)? { get set }
    
    func getViewEditing() -> Bool
    func getHeightForRowAt(_ tableView: UITableView, section: Int, type: TableViewEditPlanType) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int, type: TableViewEditPlanType) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath, type: TableViewEditPlanType) -> UITableViewCell
    func getHeightSectionView(section: Int, type: TableViewEditPlanType) -> CGFloat
    func getHeaderViewCell(_ tableView: UITableView, section: Int, type: TableViewEditPlanType) -> UIView?
}

protocol EditPlanMasterProtocol: EditPlanMasterProtocolInput, EditPlanMasterProtocolOutput {
    var input: EditPlanMasterProtocolInput { get }
    var output: EditPlanMasterProtocolOutput { get }
}

class EditPlanMasterViewModel: EditPlanMasterProtocol, EditPlanMasterProtocolOutput {
    var input: EditPlanMasterProtocolInput { return self }
    var output: EditPlanMasterProtocolOutput { return self }
    
    // MARK: - Properties
    private var editPlanMasterViewController: EditPlanMasterViewController
    // MARK: - UseCase
    private var getPlanMasterDetailUseCase: GetPlanMasterDetailUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(
        editPlanMasterViewController: EditPlanMasterViewController,
        getPlanMasterDetailUseCase: GetPlanMasterDetailUseCase = GetPlanMasterDetailUseCaseImpl()
    ) {
        self.editPlanMasterViewController = editPlanMasterViewController
        self.getPlanMasterDetailUseCase = getPlanMasterDetailUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetPlanMasterDetailSuccess: (() -> Void)?
    var didGetEmployeeSuccess: (() -> Void)?
    var didGetShopSuccess: (() -> Void)?
    var didGetTruckSuccess: (() -> Void)?
    
    //Edit
    fileprivate var listEmployee: [GetShopResponse]? = []
    fileprivate var listShop: [GetShopResponse]? = []
    fileprivate var isEditing: Bool = false
    
    //Detail
    fileprivate var listTruck: [GetAppealResponse]? = []
    
    fileprivate var planId: Int?
    
    func setPlanId(planId: Int?) {
        self.planId = planId
    }
    
    func getPlanMasterDetail() {
        guard let planId = self.planId else { return }
        editPlanMasterViewController.startLoding()
        self.getPlanMasterDetailUseCase.execute(planId: planId).sink { completion in
            debugPrint("getPlanMasterDetail \(completion)")
            self.editPlanMasterViewController.stopLoding()
        } receiveValue: { resp in
            self.didGetPlanMasterDetailSuccess?()
        }.store(in: &self.anyCancellable)
    }
    
    func setEdit(isEdit: Bool) {
        self.isEditing = isEdit
    }
    
    func getViewEditing() -> Bool {
        return self.isEditing
    }
    
    func getTruck() {
        self.listTruck?.removeAll()
        editPlanMasterViewController.startLoding()
        self.listTruck?.append(GetAppealResponse(title: "test"))
        self.didGetEmployeeSuccess?()
        self.editPlanMasterViewController.stopLoding()
    }
    
    func getEmployee() {
        listEmployee?.removeAll()
        editPlanMasterViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<3 {
                //                weakSelf.listEmployee?.append(GetAppealResponse(title: "test"))
            }
            
            weakSelf.didGetEmployeeSuccess?()
            weakSelf.editPlanMasterViewController.stopLoding()
        }
    }
    
    func getShop() {
        listShop?.removeAll()
        editPlanMasterViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<3 {
                //                weakSelf.listShop?.append(GetAppealResponse(title: "test"))
            }
            
            weakSelf.didGetShopSuccess?()
            weakSelf.editPlanMasterViewController.stopLoding()
        }
    }
    
    func getHeightForRowAt(_ tableView: UITableView, section: Int, type: TableViewEditPlanType) -> CGFloat {
        if type == .EmployeeShopTableView {
            switch section {
            case 0:
                guard let list = self.listEmployee, list.count != 0 else { return 50 }
                return 91
            default:
                guard let list = self.listShop, list.count != 0 else { return 50 }
                return 101
            }
        } else {
            guard let list = self.listTruck, list.count != 0 else { return 50 }
            return 115
        }
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int, type: TableViewEditPlanType) -> Int {
        if type == .EmployeeShopTableView {
            switch section {
            case 0:
                if self.listEmployee?.count == 0 {
                    return 1
                } else {
                    return self.listEmployee?.count ?? 0
                }
            default:
                return self.listShop?.count  == 0 ? 1 : self.listShop?.count as! Int
            }
        } else {
            return self.listTruck?.count ?? 0
        }
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath, type: TableViewEditPlanType) -> UITableViewCell {
        if type == .EmployeeShopTableView {
            switch indexPath.section {
            case 0:
                if self.listEmployee?.count == 0 {
                    return getEmptyCellForRowAt(tableView, indexPath: indexPath)
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.identifier, for: indexPath) as! EmployeeTableViewCell
                    cell.selectionStyle = .none
                    return cell
                }
            default:
                if self.listShop?.count == 0 {
                    return getEmptyCellForRowAt(tableView, indexPath: indexPath)
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ShopTableViewCell.identifier, for: indexPath) as! ShopTableViewCell
                    cell.selectionStyle = .none
                    cell.titleText.text = "Title \(self.listShop![indexPath.row].id)"
                    return cell
                }
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TruckTableViewCell.identifier, for: indexPath) as! TruckTableViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    private  func getEmptyCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as! EmptyTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    
    func getHeightSectionView(section: Int, type: TableViewEditPlanType) -> CGFloat {
        if type == .EmployeeShopTableView {
            return 25
        } else {
            return 0
        }
    }
    
    func getHeaderViewCell(_ tableView: UITableView, section: Int, type: TableViewEditPlanType) -> UIView? {
        if type == .EmployeeShopTableView {
            switch section {
            case 0:
                let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderPrimaryBottomLineTableViewCell.identifier)
                if let header = header as? HeaderPrimaryBottomLineTableViewCell {
                    header.delegate = self
                    header.setState(title: "พนักงาน", isEdit: self.getViewEditing(), section: section)
                }
                return header
            default:
                let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderPrimaryBottomLineTableViewCell.identifier)
                if let header = header as? HeaderPrimaryBottomLineTableViewCell {
                    header.delegate = self
                    header.setState(title: "ร้านค้า", isEdit: self.getViewEditing(), section: section)
                }
                return header
            }
        } else {
            return UIView()
        }

    }
}


extension EditPlanMasterViewModel: HeaderPrimaryBottomLineTableViewCellDelegate {
    func didSelectHeader(section: Int) {
        switch section {
        case 0:
            NavigationManager.instance.pushVC(to: .selectEmployee(delegate: self))
        default:
            NavigationManager.instance.pushVC(to: .sortShop(items: self.listShop, delegate: self))
        }
    }
    
}


extension EditPlanMasterViewModel: SelectEmployeeViewModelDelegate {
    func didSelectItem(item: GetShopResponse?) {
        guard let item = item else { return  }
        self.listEmployee?.removeAll()
        self.listEmployee?.append(item)
        self.didGetEmployeeSuccess?()
    }
}


extension EditPlanMasterViewModel: SortShopViewModelDelegate {
    func updateSortItems(items: [GetShopResponse]?) {
        self.listShop = items
        didGetShopSuccess?()
    }
}

enum TableViewEditPlanType {
    case TruckTableView
    case EmployeeShopTableView
}
