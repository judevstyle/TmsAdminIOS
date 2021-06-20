//
//  SelectShopViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import UIKit

class SelectShopViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    // ViewModel
    lazy var viewModel: SelectShopProtocol = {
        let vm = SelectShopViewModel(selectShopViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        
        viewModel.input.getSelectShop()
    }
    
    func configure(_ interface: SelectShopProtocol) {
        self.viewModel = interface
    }
    
}

// MARK: - Binding
extension SelectShopViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetSelectShopSuccess = didGetSelectShopSuccess()
        viewModel.output.didGetSelectShopError = didGetSelectShopError()
    }
    
    func didGetSelectShopSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
    
    func didGetSelectShopError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}


// MARK: - SETUP UI
extension SelectShopViewController {
    func setupUI() {

    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: EmptyTableViewCell.identifier)
        tableView.registerCell(identifier: ShopTableViewCell.identifier)
    }
    
}

extension SelectShopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.input.didSelectItem(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}

extension SelectShopViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
    }
}
