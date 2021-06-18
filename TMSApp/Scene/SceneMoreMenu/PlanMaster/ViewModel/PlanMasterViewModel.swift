//
//  PlanMasterViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import Foundation
import UIKit
import RxSwift

protocol PlanMasterProtocolInput {
    func getPlanMaster()
}

protocol PlanMasterProtocolOutput: class {
    var didGetPlanMasterSuccess: (() -> Void)? { get set }
    var didGetPlanMasterError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
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
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        planMasterViewController: PlanMasterViewController
    ) {
        self.planMasterViewController = planMasterViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetPlanMasterSuccess: (() -> Void)?
    var didGetPlanMasterError: (() -> Void)?
    
    fileprivate var listPlanMaster: [GetAppealResponse]? = []
    
    func getPlanMaster() {
        listPlanMaster?.removeAll()
        planMasterViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<3 {
                weakSelf.listPlanMaster?.append(GetAppealResponse(title: "test"))
            }

            weakSelf.didGetPlanMasterSuccess?()
            weakSelf.planMasterViewController.stopLoding()
        }
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
        return cell
    }
}
