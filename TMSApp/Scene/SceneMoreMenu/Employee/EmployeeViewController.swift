//
//  EmployeeViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/13/21.
//

import UIKit

class EmployeeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddEmployee: UIButton!
    
    // ViewModel
    lazy var viewModel: EmployeeProtocol = {
        let vm = EmployeeViewModel(employeeViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
    }
    
    func configure(_ interface: EmployeeProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.getEmployee()
    }
    
}

// MARK: - Binding
extension EmployeeViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetEmployeeSuccess = didGetEmployeeSuccess()
        viewModel.output.didGetEmployeeError = didGetEmployeeError()
    }
    
    func didGetEmployeeSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
    
    func didGetEmployeeError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

// MARK: - Handles
extension EmployeeViewController {
    @objc func btnEditEmployee() {
        NavigationManager.instance.pushVC(to: .editEmployee)
    }
}

// MARK: - SETUP UI
extension EmployeeViewController {
    func setupUI() {
        btnAddEmployee.setRounded(rounded: 8)
        
        btnAddEmployee.addTarget(self, action: #selector(btnEditEmployee), for: .touchUpInside)
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: EmployeeTableViewCell.identifier)
    }
    
}

extension EmployeeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}


extension EmployeeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
    }
}
