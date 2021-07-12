//
//  PlanMasterViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import Foundation
import UIKit
import Combine

protocol PlanMasterProtocolInput {
    func getPlanMaster()
    func didSelectItemAt(_ tableView: UITableView, indexPath: IndexPath)
}

protocol PlanMasterProtocolOutput: class {
    var didGetPlanMasterSuccess: (() -> Void)? { get set }
    var didGetPlanMasterError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
    func getItemForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> PlanMasterItems?
}

protocol PlanMasterProtocol: PlanMasterProtocolInput, PlanMasterProtocolOutput {
    var input: PlanMasterProtocolInput { get }
    var output: PlanMasterProtocolOutput { get }
}

class PlanMasterViewModel: PlanMasterProtocol, PlanMasterProtocolOutput {
    var input: PlanMasterProtocolInput { return self }
    var output: PlanMasterProtocolOutput { return self }
    
    // MARK: - Properties
    private var planMasterViewController: PlanMasterViewController
    // MARK: - UseCase
    private var getPlanMasterUseCase: GetPlanMasterUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(
        planMasterViewController: PlanMasterViewController,
        getPlanMasterUseCase: GetPlanMasterUseCase = GetPlanMasterUseCaseImpl()
    ) {
        self.planMasterViewController = planMasterViewController
        self.getPlanMasterUseCase = getPlanMasterUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetPlanMasterSuccess: (() -> Void)?
    var didGetPlanMasterError: (() -> Void)?
    
    fileprivate var listPlanMaster: [PlanMasterItems]? = []
    
    func getPlanMaster() {
        listPlanMaster?.removeAll()
        planMasterViewController.startLoding()
        self.getPlanMasterUseCase.execute().sink { completion in
            debugPrint("getPlanMaster \(completion)")
            self.planMasterViewController.stopLoding()
        } receiveValue: { resp in
            if let items = resp?.items {
                self.listPlanMaster = items
            }
            self.didGetPlanMasterSuccess?()
        }.store(in: &self.anyCancellable)
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listPlanMaster?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlanMasterTableViewCell.identifier, for: indexPath) as! PlanMasterTableViewCell
        cell.selectionStyle = .none
        cell.items = self.listPlanMaster?[indexPath.item]
        return cell
    }
    
    func didSelectItemAt(_ tableView: UITableView, indexPath: IndexPath) {
    }
    
    func getItemForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> PlanMasterItems? {
        return self.listPlanMaster?[indexPath.item]
    }
}
