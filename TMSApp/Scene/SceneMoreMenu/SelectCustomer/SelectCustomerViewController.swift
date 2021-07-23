//
//  SelectCustomerViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import UIKit

class SelectCustomerViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    // ViewModel
    lazy var viewModel: SelectCustomerProtocol = {
        let vm = SelectCustomerViewModel(selectCustomerViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        viewModel.input.getSelectCustomer()
    }
    
    func configure(_ interface: SelectCustomerProtocol) {
        self.viewModel = interface
    }
    
    @IBAction func didTapSort(_ sender: Any) {
        guard let shipmentId = viewModel.output.getShipmentId() else { return }
//        NavigationManager.instance.pushVC(to: .sortShipment(items: <#T##ShipmentItems?#>))
    }
}

// MARK: - Binding
extension SelectCustomerViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetSelectCustomerSuccess = didGetSelectCustomerSuccess()
    }
    
    func didGetSelectCustomerSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

// MARK: - SETUP UI
extension SelectCustomerViewController {
    func setupUI() {
//        btnSort.image = UIImage(named: "gear")
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: SequenceShipmentTableViewCell.identifier)
    }
    
}

// MARK: - Handles
extension SelectCustomerViewController {
    
}

extension SelectCustomerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.input.didSelectItemAtRow(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}

extension SelectCustomerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
    }
}
