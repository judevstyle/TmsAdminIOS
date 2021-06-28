//
//  TypeUserViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class TypeUserViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddUserType: UIButton!
    
    // ViewModel
    lazy var viewModel: TypeUserProtocol = {
        let vm = TypeUserViewModel(typeUserViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        viewModel.input.getTypeUser()
    }
    
    func configure(_ interface: TypeUserProtocol) {
        self.viewModel = interface
    }
}

// MARK: - Binding
extension TypeUserViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetTypeUserSuccess = didGetTypeUserSuccess()
        viewModel.output.didGetTypeUserError = didGetTypeUserError()
    }
    
    func didGetTypeUserSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
    
    func didGetTypeUserError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}


// MARK: - SETUP UI
extension TypeUserViewController {
    func setupUI() {
        btnAddUserType.setRounded(rounded: 8)
        btnAddUserType.addTarget(self, action: #selector(btnEditEmployee), for: .touchUpInside)
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: TypeUserTableViewCell.identifier)
    }
    
}

// MARK: - Handles
extension TypeUserViewController {
    @objc func btnEditEmployee() {
//        NavigationManager.instance.pushVC(to: .editEmployee)
    }
}

extension TypeUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = viewModel.output.getItemRowAt(tableView, indexPath: indexPath) else { return }
        NavigationManager.instance.pushVC(to: .typeUserDetail(item: item))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}


extension TypeUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
    }
}
