//
//  TruckViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class TruckViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnAddTruck: UIButton!
    
    // ViewModel
    lazy var viewModel: TruckProtocol = {
        let vm = TruckViewModel(truckViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
    }
    
    func configure(_ interface: TruckProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.getTruck()
    }
}

// MARK: - Binding
extension TruckViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetTruckSuccess = didGetTruckSuccess()
        viewModel.output.didGetTruckError = didGetTruckError()
    }
    
    func didGetTruckSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
    
    func didGetTruckError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

// MARK: - SETUP UI
extension TruckViewController {
    func setupUI() {
        btnAddTruck.setRounded(rounded: 8)
        btnAddTruck.addTarget(self, action: #selector(btnAddTruckAction), for: .touchUpInside)
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: TruckTableViewCell.identifier)
    }
    
}

// MARK: - Handles
extension TruckViewController {
    @objc func btnAddTruckAction() {
        NavigationManager.instance.pushVC(to: .editTruck)
    }
}


extension TruckViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}


extension TruckViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
    }
}
