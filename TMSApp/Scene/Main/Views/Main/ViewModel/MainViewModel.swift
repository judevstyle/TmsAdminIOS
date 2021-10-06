//
//  MainViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/5/21.
//

import Foundation
import UIKit
import Combine

protocol MainProtocolInput {
    func getHome()
    func fetchDashboard()
}

protocol MainProtocolOutput: class {
    var didGetHomeSuccess: (() -> Void)? { get set }
    var didGetHomeError: (() -> Void)? { get set }
    
    //Realtime
    var didGetDashboardSuccess: (() -> Void)? { get set }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemViewCellHeight(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getHeightSectionView(section: Int) -> CGFloat
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView?
    
    
    func getDashboardResponse() -> SocketDashboardResponse?
}

protocol MainProtocol: MainProtocolInput, MainProtocolOutput {
    var input: MainProtocolInput { get }
    var output: MainProtocolOutput { get }
}

class MainViewModel: MainProtocol, MainProtocolOutput {
    var input: MainProtocolInput { return self }
    var output: MainProtocolOutput { return self }
    
    // MARK: - Properties
    private var mainViewController: MainViewController
    
    //UseCase
    private let getDashboardUseCase: GetDashboardUseCase
    private let getShipmentWorkingUseCase :GetShipmentWorkingUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private var dataDashboard: SocketDashboardResponse?
    private var summaryCustomer: SummaryCustomer?
    private var listProduct: [TotalOrderProduct]?
    private var listShipmentWorking: [ShipmentItems]?
    
    
    init(
        mainViewController: MainViewController,
        getDashboardUseCase: GetDashboardUseCase = GetDashboardUseCaseImpl(),
        getShipmentWorkingUseCase: GetShipmentWorkingUseCase = GetShipmentWorkingUseCaseImpl()
    ) {
        self.mainViewController = mainViewController
        self.getDashboardUseCase = getDashboardUseCase
        self.getShipmentWorkingUseCase = getShipmentWorkingUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetHomeSuccess: (() -> Void)?
    var didGetHomeError: (() -> Void)?
    
    var didGetDashboardSuccess: (() -> Void)?
    
    func getHome() {
        self.listProduct?.removeAll()
        mainViewController.startLoding()
        
        self.getDashboardUseCase
            .execute().sink { completion in
                debugPrint("getDashboard \(completion)")
                switch completion {
                case .finished:
                    ToastManager.shared.toastCallAPI(title: "GetDashboard finished")
                    break
                case .failure(_):
                    ToastManager.shared.toastCallAPI(title: "GetDashboard failure")
                    break
                }
            } receiveValue: { resp in
                if let summaryCustomer = resp?.summaryCustomer {
                    self.summaryCustomer = summaryCustomer
                }
                
                if let products = resp?.totalOrderProduct {
                    self.listProduct = products
                }
                
                self.didGetHomeSuccess?()
                self.mainViewController.stopLoding()
            }.store(in: &self.anyCancellable)
        
        
        self.getShipmentWorkingUseCase.execute().sink { completion in
            debugPrint("getShipmentWorking \(completion)")
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetShipmentWorking finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "GetShipmentWorking failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp?.data?.items {
                self.listShipmentWorking = items
            }
            self.didGetHomeSuccess?()
            self.mainViewController.stopLoding()
        }.store(in: &self.anyCancellable)
        
    }
    
    func fetchDashboard() {
        SocketHelper.shared.fetchDashboard { result in
            switch result {
            case .success(let resp):
                self.dataDashboard = resp
                self.didGetDashboardSuccess?()
            case .failure(_ ):
                break
            }
        }
        emitDashboard()
    }
    
    
    private func emitDashboard(){
        var request: SocketDashboardRequest = SocketDashboardRequest()
        request.compId = 1
        SocketHelper.shared.emitDashboard(request: request) {
            debugPrint("requestDashboard \(request)")
        }
    }
    
    func getDashboardResponse() -> SocketDashboardResponse? {
        return self.dataDashboard
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.listProduct?.count == 0 ? 1 : self.listProduct?.count ?? 1
        case 2:
            return self.listShipmentWorking?.count == 0 ? 1 : self.listShipmentWorking?.count ?? 1
        default:
            return 0
        }
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainDashBoardTableViewCell.identifier, for: indexPath) as! MainDashBoardTableViewCell
            cell.selectionStyle = .none
            cell.setValue(summaryCustomer: self.summaryCustomer)
            return cell
        case 1:
            if self.listProduct?.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as! EmptyTableViewCell
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: DashBoardProductTableViewCell.identifier, for: indexPath) as! DashBoardProductTableViewCell
                cell.selectionStyle = .none
                cell.viewModel.input.setDashBoardProduct(products: self.listProduct ?? [])
                return cell
            }
        case 2:
            if self.listShipmentWorking?.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as! EmptyTableViewCell
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: DashBoardWorkingTableViewCell.identifier, for: indexPath) as! DashBoardWorkingTableViewCell
                cell.selectionStyle = .none
                cell.items = self.listShipmentWorking?[indexPath.item]
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
    func getItemViewCellHeight(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            let height = (tableView.frame.width - 24)/4
            return height
        case 1:
            if self.listProduct?.count == 0 {
                return 50
            } else {
                let marginsAndInsets = 10 * 2 + 0 + 0 + 10 * CGFloat(5 - 1)
                guard let count = self.listProduct?.count, count != 0 else { return 0 }
                let itemWidth = ((tableView.bounds.size.width - marginsAndInsets) / CGFloat(5)).rounded(.down)
                var height:CGFloat = 0.0
                height = CGFloat((count/5 + 1)) * (itemWidth + 34)
                return height
            }
        case 2:
            if self.listShipmentWorking?.count == 0 {
                return 50
            } else {
                return UITableView.automaticDimension
            }
        default:
            return 0
        }
    }
    
    func getHeightSectionView(section: Int) -> CGFloat {
        let headerHeight: CGFloat
        switch section {
        case 0:
            // hide the header
            headerHeight = CGFloat.leastNonzeroMagnitude
        default:
            headerHeight = 25
        }
        return headerHeight
    }
    
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
            let header = HeaderPrimaryBottomLineViewCell()
            if section == 1 {
                header.setState(title: "รายการขายสินค้า", isEdit: false, section: section)
            } else {
                header.setState(title: "กำลังทำงาน", isEdit: false, section: section)
            }
            return header
        }
    }
}
