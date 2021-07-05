//
//  AssetWithdrawViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import UIKit

class AssetWithdrawViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnSave: ButtonPrimaryView!
    
    // ViewModel
    lazy var viewModel: AssetWithdrawProtocol = {
        let vm = AssetWithdrawViewModel(assetWithdrawViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        viewModel.input.getAssetWithdraw()
    }
    
    func configure(_ interface: AssetWithdrawProtocol) {
        self.viewModel = interface
    }
}

// MARK: - Binding
extension AssetWithdrawViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetAssetWithdrawSuccess = didGetAssetWithdrawSuccess()
    }
    
    func didGetAssetWithdrawSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

// MARK: - SETUP UI
extension AssetWithdrawViewController {
    func setupUI() {
        btnSave.delegate = self
        btnSave.setTitle(title: "เบิกอุปกรณ์")
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: AssetStockTableViewCell.identifier)
    }
    
}

extension AssetWithdrawViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        NavigationManager.instance.pushVC(to: .assetDetail)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}


extension AssetWithdrawViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
    }
}

extension AssetWithdrawViewController: ButtonPrimaryViewDelegate {
    func onClickButton() {
        guard let items = self.viewModel.output.getAssetDetail(), let astId = items.astId  else { return }
        NavigationManager.instance.pushVC(to: .modalAssetStock(astId: astId, delegate: self, modalAssetType: .AssetPickupStock), presentation: .PopupSheet(completion: {
            
        }))
    }
}

extension AssetWithdrawViewController: ModalAssetStockViewModelDelegate {
    func didUpdateSuccess() {
        viewModel.input.getAssetWithdraw()
    }
}
