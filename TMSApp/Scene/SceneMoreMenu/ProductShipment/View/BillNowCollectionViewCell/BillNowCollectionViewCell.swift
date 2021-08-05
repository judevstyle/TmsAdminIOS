//
//  BillNowCollectionViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/4/21.
//

import UIKit

class BillNowCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BillNowCollectionViewCell"

    @IBOutlet var tableView: UITableView!
    
    // ViewModel
    lazy var viewModel: BillNowCollectionViewCellProtocol = {
        let vm = BillNowCollectionViewCellViewModel()
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.registerCell(identifier: BillPaymentTableViewCell.identifier)
    }
    
    func setupUI() {

    }
    
    func configure(_ interface: BillNowCollectionViewCellProtocol) {
        self.viewModel = interface
    }

}

// MARK: - Binding
extension BillNowCollectionViewCell {
    
    func bindToViewModel() {
        viewModel.output.didGetOrderSuccess = didGetOrderSuccess()
    }
    
    func didGetOrderSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

extension BillNowCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = viewModel.output.getItemOrder(index: indexPath.item), let orderId = item.orderId else { return }
        NavigationManager.instance.pushVC(to: .orderCartBill(orderId: orderId))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getItemViewCell(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getItemViewCellHeight()
    }
}
