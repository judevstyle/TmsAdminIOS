//
//  AssetListViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import UIKit

class AssetListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnAddAsset: UIButton!
    
    // ViewModel
    lazy var viewModel: AssetListProtocol = {
        let vm = AssetListViewModel(assetListViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        viewModel.input.getAssetList()
    }
    
    func configure(_ interface: AssetListProtocol) {
        self.viewModel = interface
    }
}

// MARK: - Binding
extension AssetListViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetAssetListSuccess = didGetAssetListSuccess()
        viewModel.output.didGetAssetListError = didGetAssetListError()
    }
    
    func didGetAssetListSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
    
    func didGetAssetListError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

// MARK: - SETUP UI
extension AssetListViewController {
    func setupUI() {
        btnAddAsset.setRounded(rounded: 8)
        btnAddAsset.addTarget(self, action: #selector(btnAddAssetAction), for: .touchUpInside)
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: AssetTableViewCell.identifier)
    }
    
}

// MARK: - Handles
extension AssetListViewController {
    @objc func btnAddAssetAction() {
        NavigationManager.instance.pushVC(to: .editAsset)
    }
}


extension AssetListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NavigationManager.instance.pushVC(to: .assetDetail)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}


extension AssetListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
    }
}
