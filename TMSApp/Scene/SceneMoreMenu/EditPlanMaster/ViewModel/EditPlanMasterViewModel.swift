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
    
    //Detail
    func getPlanMasterDetail()
    func setPlanId(planId: Int?)
    
    //Edit or Create
    func getListTruckCar()
    func createProduct(truckName: String,
                       planType: String,
                       planName: String,
                       planDesc: String
    )
    
    func setEdit(isEdit: Bool)
    func setSelectDays(dailys: [WeeklyType])
}

protocol EditPlanMasterProtocolOutput: class {
    //Detail
    var didGetPlanMasterDetailSuccess: (() -> Void)? { get set }
    var didGetTruckSuccess: (() -> Void)? { get set }
    var didGetDailySuccess: (() -> Void)? { get set }
    var didGetEmployeeSuccess: (() -> Void)? { get set }
    var didGetShopSuccess: (() -> Void)? { get set }
    
    //Edit or Create
    var didGetTruckCarSuccess: (() -> Void)? { get set }
    
    func getViewEditing() -> Bool
    func getHeightForRowAt(_ tableView: UITableView, section: Int, type: TableViewEditPlanType) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int, type: TableViewEditPlanType) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath, type: TableViewEditPlanType) -> UITableViewCell
    func getHeightSectionView(section: Int, type: TableViewEditPlanType) -> CGFloat
    func getHeaderViewCell(_ tableView: UITableView, section: Int, type: TableViewEditPlanType) -> UIView?
    
    func getPlanMasterDetail() -> PlanMasterItems?
    func getSelectDailys() -> [WeeklyType]
    
    func getListTrukCar() -> [TruckItems]?
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
    //Detail
    private var getPlanMasterDetailUseCase: GetPlanMasterDetailUseCase
    // Edit or Create
    private var getTruckUseCase: GetTruckUseCase
    private var postPlanMasterUseCase: PostPlanMasterUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(
        editPlanMasterViewController: EditPlanMasterViewController,
        getPlanMasterDetailUseCase: GetPlanMasterDetailUseCase = GetPlanMasterDetailUseCaseImpl(),
        getTruckUseCase: GetTruckUseCase = GetTruckUseCaseImpl(),
        postPlanMasterUseCase: PostPlanMasterUseCase = PostPlanMasterUseCaseImpl()
    ) {
        self.editPlanMasterViewController = editPlanMasterViewController
        self.getPlanMasterDetailUseCase = getPlanMasterDetailUseCase
        self.getTruckUseCase = getTruckUseCase
        self.postPlanMasterUseCase = postPlanMasterUseCase
    }
    
    // MARK - Data-binding OutPut
    //Detail
    var didGetPlanMasterDetailSuccess: (() -> Void)?
    var didGetTruckSuccess: (() -> Void)?
    var didGetDailySuccess: (() -> Void)?
    var didGetEmployeeSuccess: (() -> Void)?
    var didGetShopSuccess: (() -> Void)?
    
    //Edit or Create
    var didGetTruckCarSuccess: (() -> Void)?
    
    //Share
    fileprivate var listDays: [WeeklyType] = [.Monday, .Tuesday, .Wednesday, .Thursday, .Friday, .Saturday, .Sunday]
    
    //Edit
    fileprivate var isEditing: Bool = false
    fileprivate var listTruckCar: [TruckItems]? = []
    
    //Detail
    fileprivate var listTruck: [TruckItems]? = []
    fileprivate var listSelectedDays: [WeeklyType] = []
    fileprivate var listEmployee: [EmployeeItems]? = []
    fileprivate var listShop: [CustomerItems]? = []
    
    fileprivate var planMasterDetail: PlanMasterItems?
    
    fileprivate var planId: Int?
    
    func setPlanId(planId: Int?) {
        self.planId = planId
    }
    
    //Detail
    func getPlanMasterDetail() {
        guard let planId = self.planId else { return }
        editPlanMasterViewController.startLoding()
        self.listTruck?.removeAll()
        self.listDays.removeAll()
        self.listEmployee?.removeAll()
        self.listShop?.removeAll()
        
        self.getPlanMasterDetailUseCase.execute(planId: planId).sink { completion in
            debugPrint("getPlanMasterDetail \(completion)")
            self.editPlanMasterViewController.stopLoding()
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetPlanMasterDetail finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "GetPlanMasterDetail failure")
                break
            }
            
        } receiveValue: { resp in
            if let item = resp?.data {
                self.planMasterDetail = item
                
                //Truck
                if let truck = item.truck {
                    self.listTruck?.append(truck)
                    self.didGetTruckSuccess?()
                }
                
                //Daily
                if let dailys = item.daily {
                    self.setSelectDaily(dailys: dailys)
                }
                
                //Employee
                if let employee = item.employees {
                    self.listEmployee = employee
                    self.didGetEmployeeSuccess?()
                }
                
                //PlanCustomerItems
                if let planCustomer = item.planCustomer {
//                    self.listShop = customer
                    planCustomer.forEach({ item in
                        if let customer = item.customer {
                            self.listShop?.append(customer)
                        }
                    })
                    self.didGetShopSuccess?()
                }
                
                self.didGetPlanMasterDetailSuccess?()
            }
        }.store(in: &self.anyCancellable)
    }
    
    func setEdit(isEdit: Bool) {
        self.isEditing = isEdit
    }
    
    func setSelectDaily(dailys: [DailyItems]){
        // 1-7 Weekend
        self.listSelectedDays.removeAll()
        dailys.forEach({ item in
            switch item.dailyId {
            case 1:
                self.listSelectedDays.append(.Monday)
            case 2:
                self.listSelectedDays.append(.Tuesday)
            case 3:
                self.listSelectedDays.append(.Wednesday)
            case 4:
                self.listSelectedDays.append(.Thursday)
            case 5:
                self.listSelectedDays.append(.Friday)
            case 6:
                self.listSelectedDays.append(.Saturday)
            case 7:
                self.listSelectedDays.append(.Sunday)
            default: break
            }
        })
        
        didGetDailySuccess?()
    }
    
    func getViewEditing() -> Bool {
        return self.isEditing
    }
    
    func getPlanMasterDetail() -> PlanMasterItems? {
        return self.planMasterDetail
    }
    
    func getSelectDailys() -> [WeeklyType] {
        return self.listSelectedDays
    }
    
    func createProduct(truckName: String, planType: String, planName: String, planDesc: String) {
        var request = PostPlanMasterRequest()
        request.compId = 1
        
        
        if let truck = listTruckCar?.first(where: { "ทะเบียน : \($0.registration_number ?? "")" == truckName }) {
            debugPrint("truckId \(truck.truck_id)")
            request.truckId = truck.truck_id
        }
        
        request.planName = planName
        request.planDesc = planDesc
        request.planType = planType
        
        //List Employee
        var employees: [PlanMasterEmployeesRequest] = []
        listEmployee?.forEach({ item in
            var requestEmployee = PlanMasterEmployeesRequest()
            requestEmployee.del = 0
            requestEmployee.empId = item.empId
            employees.append(requestEmployee)
        })
        request.employees = employees
        
        //List planCustomers
        var planCustomers: [PlanMasterPlanCustomersRequest] = []
        listShop?.enumerated().forEach({ (index, item) in
            var requestCustomers = PlanMasterPlanCustomersRequest()
            requestCustomers.del = 0
            requestCustomers.cusId = item.cusId
            requestCustomers.planCusSeq = index
            planCustomers.append(requestCustomers)
        })
        request.planCustomers = planCustomers
        
        
        if planType == "N" {
            request.planSpecialDay = nil
            //List planCustomers
            var dailys: [PlanMasterDailyRequest] = []
            listSelectedDays.forEach({ item in
                var requestDailys = PlanMasterDailyRequest()
                requestDailys.del = 0
                requestDailys.dailyId = item.id
                dailys.append(requestDailys)
            })
            request.daily = dailys
            
        } else if planType == "Y" {
            request.daily = nil
        }
        
        
        editPlanMasterViewController.startLoding()
        self.postPlanMasterUseCase.execute(request: request).sink { completion in
            debugPrint("postPlanMaster \(completion)")
            self.editPlanMasterViewController.stopLoding()
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "PostPlanMaster finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "PostPlanMaster failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp {
                if items.success == true {
                    self.editPlanMasterViewController.navigationController?.popViewController(animated: true)
                }
            }
        }.store(in: &self.anyCancellable)
    }
    
    func setSelectDays(dailys: [WeeklyType]) {
        self.listSelectedDays = dailys
    }
    
    //Edit or Create
    func getListTruckCar() {
        self.listTruckCar?.removeAll()
        self.editPlanMasterViewController.startLoding()
        
        self.getTruckUseCase.execute().sink { completion in
            debugPrint("getTruckUseCase \(completion)")
            self.editPlanMasterViewController.stopLoding()
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetTruck finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "GetTruck failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp?.items {
                self.listTruckCar = items
                self.didGetTruckCarSuccess?()
            }
        }.store(in: &self.anyCancellable)
    }
    
    func getListTrukCar() -> [TruckItems]? {
        return self.listTruckCar
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
            return 95
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
                    cell.items = self.listEmployee?[indexPath.item]
                    return cell
                }
            default:
                if self.listShop?.count == 0 {
                    return getEmptyCellForRowAt(tableView, indexPath: indexPath)
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ShopTableViewCell.identifier, for: indexPath) as! ShopTableViewCell
                    cell.selectionStyle = .none
                    cell.items = self.listShop?[indexPath.item]
                    return cell
                }
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TruckTableViewCell.identifier, for: indexPath) as! TruckTableViewCell
            cell.selectionStyle = .none
            cell.items = self.listTruck?[indexPath.item]
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
                let header = HeaderPrimaryBottomLineViewCell()
                header.delegate = self
                header.setState(title: "พนักงาน", isEdit: self.getViewEditing(), section: section)
                
                if self.getViewEditing() {
                    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleEditEmployeeTap(_:)))
                    header.addGestureRecognizer(tap)
                    header.isUserInteractionEnabled = true
                }
                
                return header
            default:
                let header = HeaderPrimaryBottomLineViewCell()
                header.delegate = self
                header.setState(title: "ร้านค้า", isEdit: self.getViewEditing(), section: section)
                
                if self.getViewEditing() {
                    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleEditCustomerTap(_:)))
                    header.addGestureRecognizer(tap)
                    header.isUserInteractionEnabled = true
                }
                return header
            }
        } else {
            return UIView()
        }
        
    }
    
    
    @objc func handleEditEmployeeTap(_ sender: UITapGestureRecognizer) {
        NavigationManager.instance.pushVC(to: .selectEmployee(delegate: self))
     }
    
    @objc func handleEditCustomerTap(_ sender: UITapGestureRecognizer) {
        NavigationManager.instance.pushVC(to: .sortShop(items: self.listShop, delegate: self))
     }

}


extension EditPlanMasterViewModel: HeaderPrimaryBottomLineViewCellDelegate {
    func didSelectHeader(section: Int) {
//        switch section {
//        case 0:
//            NavigationManager.instance.pushVC(to: .selectEmployee(delegate: self))
//        default:
//            NavigationManager.instance.pushVC(to: .sortShop(items: self.listShop, delegate: self))
//        }
    }
    
}


extension EditPlanMasterViewModel: SelectEmployeeViewModelDelegate {
    func didSelectItem(item: EmployeeItems?) {
        guard let item = item else { return  }
        self.listEmployee?.removeAll()
        self.listEmployee?.append(item)
        self.didGetEmployeeSuccess?()
    }
}


extension EditPlanMasterViewModel: SortShopViewModelDelegate {
    func updateSortItems(items: [CustomerItems]?) {
        self.listShop = items
        didGetShopSuccess?()
    }
}

enum TableViewEditPlanType {
    case TruckTableView
    case EmployeeShopTableView
}
