//
//  AssetDetailViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import UIKit

class AssetDetailViewController: UIViewController {

    @IBOutlet var imageShow: UIImageView!
    
    @IBOutlet var nameText: UILabel!
    
    @IBOutlet var descText: UILabel!
    
    @IBOutlet var btnWithdrawItem: UIButton!
    
    @IBOutlet var btnAddItem: ButtonPrimaryView!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var bgBadge: UIView!
    @IBOutlet var titleBadge: UIButton!

    // ViewModel
    lazy var viewModel: AssetDetailProtocol = {
        let vm = AssetDetailViewModel(assetDetailViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        registerCell()
        viewModel.input.getAssetStock()
    }

    @IBAction func btnWithdrawItemAction(_ sender: Any) {
        guard let items = viewModel.output.getAssetDetail() else { return }
        NavigationManager.instance.pushVC(to: .assetWithdraw(items: items))
    }
    
    func configure(_ interface: AssetDetailProtocol) {
        self.viewModel = interface
    }
}

// MARK: - Binding
extension AssetDetailViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetAssetStockSuccess = didGetAssetStockSuccess()
    }
    
    func didGetAssetStockSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

// MARK: - SETUP UI
extension AssetDetailViewController {
    func setupUI() {
        self.btnAddItem.delegate = self
        self.btnAddItem.setTitle(title: "เพิ่มสต๊อกสินค้า")
        
        
        self.btnWithdrawItem.setRounded(rounded: 8)
        self.btnWithdrawItem.layer.borderColor = UIColor.Primary.cgColor
        self.btnWithdrawItem.layer.borderWidth = 0.5
        
        setupValue()
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: AssetStockTableViewCell.identifier)
    }
    
    func setupValue() {
        guard let items = viewModel.output.getAssetDetail() else { return }
        
        
        nameText.text = items.assetName ?? ""
        descText.text = items.assetDesc ?? ""
        
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(items.assetImg ?? "")") else { return }
        imageShow.kf.setImageDefault(with: urlImage)
        
    }
    
}

extension AssetDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        NavigationManager.instance.pushVC(to: .assetDetail)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}


extension AssetDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
    }
}


extension AssetDetailViewController: ButtonPrimaryViewDelegate {
    func onClickButton() {
        guard let items = self.viewModel.output.getAssetDetail(), let astId = items.astId  else { return }
        NavigationManager.instance.pushVC(to: .modalAssetStock(astId: astId, delegate: self, modalAssetType: .AssetStock), presentation: .PopupSheet(completion: {
            
        }))
    }
}

extension AssetDetailViewController: ModalAssetStockViewModelDelegate {
    func didUpdateSuccess() {
        viewModel.input.getAssetStock()
    }
}
