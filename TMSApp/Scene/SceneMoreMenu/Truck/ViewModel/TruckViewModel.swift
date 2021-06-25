//
//  TruckViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import Foundation
import UIKit

protocol TruckProtocolInput {
    func getTruck()
}

protocol TruckProtocolOutput: class {
    var didGetTruckSuccess: (() -> Void)? { get set }
    var didGetTruckError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol TruckProtocol: TruckProtocolInput, TruckProtocolOutput {
    var input: TruckProtocolInput { get }
    var output: TruckProtocolOutput { get }
}

class TruckViewModel: TruckProtocol, TruckProtocolOutput {
    var input: TruckProtocolInput { return self }
    var output: TruckProtocolOutput { return self }
    
    // MARK: - Properties
    private var truckViewController: TruckViewController
    
    
    
    init(
        truckViewController: TruckViewController
    ) {
        self.truckViewController = truckViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetTruckSuccess: (() -> Void)?
    var didGetTruckError: (() -> Void)?
    
    fileprivate var listTruck: [GetAppealResponse]? = []
    
    func getTruck() {
        listTruck?.removeAll()
        truckViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<3 {
                weakSelf.listTruck?.append(GetAppealResponse(title: "test"))
            }

            weakSelf.didGetTruckSuccess?()
            weakSelf.truckViewController.stopLoding()
        }
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listTruck?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TruckTableViewCell.identifier, for: indexPath) as! TruckTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}
