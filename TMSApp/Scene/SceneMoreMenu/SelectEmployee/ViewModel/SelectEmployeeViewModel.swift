//
//  SelectSelectEmployeeViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import Foundation
import RxSwift
import UIKit


public protocol SelectEmployeeViewModelDelegate {
    func didSelectItem(item: GetShopResponse?)
}

protocol SelectEmployeeProtocolInput {
    func getSelectEmployee()
    func didSelectItem(_ tableView: UITableView, indexPath: IndexPath)
    func setDelegate(delegate: SelectEmployeeViewModelDelegate)
}

protocol SelectEmployeeProtocolOutput: class {
    var didGetSelectEmployeeSuccess: (() -> Void)? { get set }
    var didGetSelectEmployeeError: (() -> Void)? { get set }
    
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
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        selectEmployeeViewController: SelectEmployeeViewController
    ) {
        self.selectEmployeeViewController = selectEmployeeViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetSelectEmployeeSuccess: (() -> Void)?
    var didGetSelectEmployeeError: (() -> Void)?
    
    fileprivate var listSelectEmployee: [GetShopResponse]? = []
    
    public var delegate: SelectEmployeeViewModelDelegate?
    
    func setDelegate(delegate: SelectEmployeeViewModelDelegate) {
        self.delegate = delegate
    }
    
    func getSelectEmployee() {
        listSelectEmployee?.removeAll()
        selectEmployeeViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<10 {
                weakSelf.listSelectEmployee?.append(GetShopResponse(title: "test"))
            }

            weakSelf.didGetSelectEmployeeSuccess?()
            weakSelf.selectEmployeeViewController.stopLoding()
        }
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
        return cell
    }
    
    func didSelectItem(_ tableView: UITableView, indexPath: IndexPath) {
        self.delegate?.didSelectItem(item: self.listSelectEmployee?[indexPath.row])
        selectEmployeeViewController.navigationController?.popViewController(animated: true)
    }
    
}
