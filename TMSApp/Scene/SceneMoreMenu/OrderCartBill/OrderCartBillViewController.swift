//
//  OrderCartBillViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/5/21.
//

import UIKit

class OrderCartBillViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var sumPrice: UILabel!
    @IBOutlet var discountPrice: UILabel!
    @IBOutlet var sumOverAll: UILabel!
    
    
    lazy var viewModel: OrderCartBillProtocol = {
        let vm = OrderCartBillViewModel(orderCartBillViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        viewModel.input.fetchOrderCartBill()
    }
    
    func configure(_ interface: OrderCartBillProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        viewModel.input.fetchOrderCart()
    }
}

// MARK: - Binding
extension OrderCartBillViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetOrderCartBillSuccess = didGetOrderCartBillSuccess()
        viewModel.output.didGetOrderCartBillError = didGetOrderCartBillError()
    }
    
    func didGetOrderCartBillSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
            weakSelf.setupValue()
        }
    }
    
    func didGetOrderCartBillError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

extension OrderCartBillViewController {
    func setupUI(){

    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.register(HeaderLabelTableViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderLabelTableViewCell.identifier)
        tableView.registerCell(identifier: OrderCartTableViewCell.identifier)
    }
    
    func setupValue() {
        guard let item = self.viewModel.output.getItem() else { return }
        sumPrice.text = "\(item.balance)"
        discountPrice.text = "0"
        sumOverAll.text = "\(item.balance)"
    }
}

extension OrderCartBillViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getItemViewCellHeight()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.output.getHeightSectionView(section: section)
    }
}

extension OrderCartBillViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfOrderCartBill(tableView, section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.output.getNumberOfSections(in: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getItemViewCell(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel.output.getHeaderViewCell(tableView, section: section)
    }
}
