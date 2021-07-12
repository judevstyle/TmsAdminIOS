//
//  CollectibleDetailViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/20/21.
//

import UIKit

class CollectibleDetailViewController: UIViewController {

    @IBOutlet var imageShow: UIImageView!
    
    @IBOutlet var nameText: UILabel!
    
    @IBOutlet var descText: UILabel!
    
    @IBOutlet var derutionText: UILabel!
    @IBOutlet var tableView: UITableView!

    @IBOutlet var pointText: UILabel!
    // ViewModel
    lazy var viewModel: CollectibleDetailProtocol = {
        let vm = CollectibleDetailViewModel(CollectibleDetailViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        registerCell()
        viewModel.input.getCollectibleDetail()
    }

    func configure(_ interface: CollectibleDetailProtocol) {
        self.viewModel = interface
    }
}

// MARK: - Binding
extension CollectibleDetailViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetCollectibleDetailSuccess = didGetCollectibleDetailSuccess()
        viewModel.output.didGetCollectibleDetailError = didGetCollectibleDetailError()
    }
    
    func didGetCollectibleDetailSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
    
    func didGetCollectibleDetailError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

// MARK: - SETUP UI
extension CollectibleDetailViewController {
    func setupUI() {
        setupValue()
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: CollectibleUserUseTableViewCell.identifier)
    }
    
    func setupValue() {
        guard let items = viewModel.output.getCollectibleDetail() else { return }
        nameText.text = items.clbTitle ?? ""
        descText.text = items.clbDescript ?? ""
        derutionText.text = "\(items.campaignStartDate ?? "") - \(items.campaignEndDate ?? "")"
        pointText.text = "\(items.rewardPoint ?? 0)"
        
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(items.clbImg ?? "")") else { return }
        imageShow.kf.setImageDefault(with: urlImage)
    }
    
}

extension CollectibleDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        NavigationManager.instance.pushVC(to: .CollectibleDetail)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}


extension CollectibleDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
    }
}


extension CollectibleDetailViewController: ButtonPrimaryViewDelegate {
    func onClickButton() {
//        NavigationManager.instance.pushVC(to: .modalAssetStock(astId: 0, delegate: self), presentation: .PopupSheet(completion: {
//            
//        }))
    }
}

extension CollectibleDetailViewController: ModalAssetStockViewModelDelegate {
    func didUpdateSuccess() {
    }
}
