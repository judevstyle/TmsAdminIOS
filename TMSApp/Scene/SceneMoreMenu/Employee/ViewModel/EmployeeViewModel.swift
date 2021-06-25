//
//  EmployeeViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/13/21.
//

import Foundation
import UIKit

protocol EmployeeProtocolInput {
    func getEmployee()
}

protocol EmployeeProtocolOutput: class {
    var didGetEmployeeSuccess: (() -> Void)? { get set }
    var didGetEmployeeError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol EmployeeProtocol: EmployeeProtocolInput, EmployeeProtocolOutput {
    var input: EmployeeProtocolInput { get }
    var output: EmployeeProtocolOutput { get }
}

class EmployeeViewModel: EmployeeProtocol, EmployeeProtocolOutput {
    var input: EmployeeProtocolInput { return self }
    var output: EmployeeProtocolOutput { return self }
    
    // MARK: - Properties
    private var employeeViewController: EmployeeViewController
    
    
    
    init(
        employeeViewController: EmployeeViewController
    ) {
        self.employeeViewController = employeeViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetEmployeeSuccess: (() -> Void)?
    var didGetEmployeeError: (() -> Void)?
    
    fileprivate var listEmployee: [GetAppealResponse]? = []
    
    func getEmployee() {
        listEmployee?.removeAll()
        employeeViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<10 {
                weakSelf.listEmployee?.append(GetAppealResponse(title: "test"))
            }

            weakSelf.didGetEmployeeSuccess?()
            weakSelf.employeeViewController.stopLoding()
        }
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listEmployee?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.identifier, for: indexPath) as! EmployeeTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}
