//
//  EmployeeViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/13/21.
//

import Foundation
import UIKit
import Combine

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
    // MARK: - UseCase
    private var getEmployeeUseCase: GetEmployeeUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    
    init(
        employeeViewController: EmployeeViewController,
        getEmployeeUseCase: GetEmployeeUseCase = GetEmployeeUseCaseImpl()
    ) {
        self.employeeViewController = employeeViewController
        self.getEmployeeUseCase = getEmployeeUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetEmployeeSuccess: (() -> Void)?
    var didGetEmployeeError: (() -> Void)?
    
    fileprivate var listEmployee: [EmployeeItems]? = []
    
    func getEmployee() {
        listEmployee?.removeAll()
        employeeViewController.startLoding()
        
        self.getEmployeeUseCase.execute().sink { completion in
            debugPrint("getEmployee \(completion)")
            self.employeeViewController.stopLoding()
        } receiveValue: { resp in
            
            if let items = resp {
                self.listEmployee = items
                self.didGetEmployeeSuccess?()
            }
        }.store(in: &self.anyCancellable)
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
        cell.items = self.listEmployee?[indexPath.item]
        return cell
    }
}
