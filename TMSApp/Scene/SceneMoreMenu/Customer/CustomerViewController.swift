//
//  CustomerViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class CustomerViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnAddCustomer: UIButton!
    
    // ViewModel
    lazy var viewModel: CustomerProtocol = {
        let vm = CustomerViewModel(customerViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        registerCell()
    }

    func configure(_ interface: CustomerProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.getCustomer()
    }
    
}

// MARK: - Binding
extension CustomerViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetCustomerkSuccess = didGetCustomerkSuccess()
    }
    
    func didGetCustomerkSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

// MARK: - SETUP UI
extension CustomerViewController {
    func setupUI() {
        btnAddCustomer.setRounded(rounded: 8)
        btnAddCustomer.addTarget(self, action: #selector(btnAddCustomerAction), for: .touchUpInside)
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: ShopTableViewCell.identifier)
    }
    
}

// MARK: - Handles
extension CustomerViewController {
    @objc func btnAddCustomerAction() {
//        NavigationManager.instance.pushVC(to: .editEmployee)
    }
}

extension CustomerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}


extension CustomerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
    }
}

