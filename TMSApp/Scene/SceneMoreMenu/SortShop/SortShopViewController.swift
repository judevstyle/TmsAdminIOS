//
//  SortShopViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import UIKit

class SortShopViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    // ViewModel
    lazy var viewModel: SortShopProtocol = {
        let vm = SortShopViewModel(sortShopViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        viewModel.input.getListSort()
    }
    
    func configure(_ interface: SortShopProtocol) {
        self.viewModel = interface
    }
    
}

// MARK: - Binding
extension SortShopViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetSortShopSuccess = didGetSortShopSuccess()
    }
    
    func didGetSortShopSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
            weakSelf.tableView.isEditing = weakSelf.viewModel.output.getTableViewEditing()
        }
    }
    
}


// MARK: - SETUP UI
extension SortShopViewController {
    func setupUI() {
        
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didAddShopButton))
        button.tintColor = .white
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func didAddShopButton() {
        viewModel.input.didOpenShop()
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: ShopTableViewCell.identifier)
        tableView.registerCell(identifier: EmptyTableViewCell.identifier)
    }
    
}

extension SortShopViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}


extension SortShopViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.input.swapItem(sourceIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}
