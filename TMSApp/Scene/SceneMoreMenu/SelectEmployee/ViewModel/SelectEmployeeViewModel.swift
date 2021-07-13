//
//  SelectSelectEmployeeViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import Foundation
import UIKit
import Combine


public protocol SelectEmployeeViewModelDelegate {
    func didSelectItem(item: EmployeeItems?)
}

protocol SelectEmployeeProtocolInput {
    func getSelectEmployee()
    func didSelectItem(_ tableView: UITableView, indexPath: IndexPath)
    func setDelegate(delegate: SelectEmployeeViewModelDelegate)
}

protocol SelectEmployeeProtocolOutput: class {
    var didGetEmployeeSuccess: (() -> Void)? { get set }
    var didGetEmployeeError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol SelectEmployeeProtocol: SelectEmployeeProtocolInput, SelectEmployeeProtocolOutput {
    var input: SelectEmployeeProtocolInput { get }
    var output: SelectEmployeeProtocolOutput { get }
}

class SelectEmployeeViewModel: SelectEmployeeProtocol, SelectEmployeeProtocolOutput {
    var input: SelectEmployeeProtocolInput { return self }
    var output: SelectEmployeeProtocolOutput { return self }
    
    // MARK: - Properties
    private var selectEmployeeViewController: SelectEmployeeViewController
    // MARK: - UseCase
    private var getEmployeeUseCase: GetEmployeeUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    init(
        selectEmployeeViewController: SelectEmployeeViewController,
        getEmployeeUseCase: GetEmployeeUseCase = GetEmployeeUseCaseImpl()
    ) {
        self.selectEmployeeViewController = selectEmployeeViewController
        self.getEmployeeUseCase = getEmployeeUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetEmployeeSuccess: (() -> Void)?
    var didGetEmployeeError: (() -> Void)?
    
    
    fileprivate var listSelectEmployee: [EmployeeItems]? = []
    
    public var delegate: SelectEmployeeViewModelDelegate?
    
    func setDelegate(delegate: SelectEmployeeViewModelDelegate) {
        self.delegate = delegate
    }
    
    func getSelectEmployee() {
        listSelectEmployee?.removeAll()
        selectEmployeeViewController.startLoding()
        
        self.getEmployeeUseCase.execute().sink { completion in
            debugPrint("getEmployeeUseCase \(completion)")
            self.selectEmployeeViewController.stopLoding()
        } receiveValue: { resp in
            if let item = resp {
                self.listSelectEmployee = item
                self.didGetEmployeeSuccess?()
            }
        }.store(in: &self.anyCancellable)
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listSelectEmployee?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.identifier, for: indexPath) as! EmployeeTableViewCell
        cell.selectionStyle = .none
        cell.items = self.listSelectEmployee?[indexPath.item]
        return cell
    }
    
    func didSelectItem(_ tableView: UITableView, indexPath: IndexPath) {
        self.delegate?.didSelectItem(item: self.listSelectEmployee?[indexPath.row])
        selectEmployeeViewController.navigationController?.popViewController(animated: true)
    }
    
}
