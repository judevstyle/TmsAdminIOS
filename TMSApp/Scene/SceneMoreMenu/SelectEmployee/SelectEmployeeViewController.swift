//
//  SelectEmployeeViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import UIKit

class SelectEmployeeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    // ViewModel
    lazy var viewModel: SelectEmployeeProtocol = {
        let vm = SelectEmployeeViewModel(selectEmployeeViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        
        viewModel.input.getSelectEmployee()
    }
    
    func configure(_ interface: SelectEmployeeProtocol) {
        self.viewModel = interface
    }
    
}

// MARK: - Binding
extension SelectEmployeeViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetEmployeeSuccess = didGetEmployeeSuccess()
    }
    
    func didGetEmployeeSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}


// MARK: - SETUP UI
extension SelectEmployeeViewController {
    func setupUI() {
        searchBar.delegate = self
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

extension SelectEmployeeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.input.didSelectItem(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}


extension SelectEmployeeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
    }
}


extension SelectEmployeeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text != "" else { return }
        searchBar.text = ""
        self.view.endEditing(true)
        viewModel.input.getSelectEmployee()
    }
}
