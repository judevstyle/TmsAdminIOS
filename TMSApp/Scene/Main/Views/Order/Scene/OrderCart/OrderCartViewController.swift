//
//  OrderCartViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/30/21.
//

import UIKit

class OrderCartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageThubnail: UIImageView!
    @IBOutlet weak var orderNo: UILabel!
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var addressText: UILabel!
    
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var overallView: UIView!
    
    
    @IBOutlet weak var sumPrice: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var sumOverAll: UILabel!
    
    lazy var viewModel: OrderCartProtocol = {
        let vm = OrderCartViewModel(orderCartViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        viewModel.input.fetchOrderCart()
        
        totalView.isHidden = false
        discountView.isHidden = false
        overallView.isHidden = false
    }
    
    func configure(_ interface: OrderCartProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        viewModel.input.fetchOrderCart()
    }
    
    @IBAction func handleConfirmOrder(_ sender: Any) {
        viewModel.input.confirmOrderCart()
    }
}

// MARK: - Binding
extension OrderCartViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetOrderCartSuccess = didGetOrderCartSuccess()
        viewModel.output.didGetOrderCartError = didGetOrderCartError()
    }
    
    func didGetOrderCartSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
            weakSelf.setupValue()
        }
    }
    
    func didGetOrderCartError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

extension OrderCartViewController {
    func setupUI(){
        imageThubnail.setRounded(rounded: 8)
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.register(HeaderLabelTableViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderLabelTableViewCell.identifier)
        tableView.registerCell(identifier: OrderCartTableViewCell.identifier)
    }
    
    func setupValue() {
        guard let item = self.viewModel.output.getItem() else { return }
        orderNo.text = "Order ID \(item.orderNo ?? "")"
        descText.text = item.customer?.displayName ?? ""
        addressText.text = item.customer?.address ?? ""
        
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(item.customer?.avatar ?? "")") else { return }
        imageThubnail.kf.setImageDefault(with: urlImage)
        
        sumPrice.text = "\(item.balance)"
        discountPrice.text = "0"
        sumOverAll.text = "\(item.balance)"
    }
}

extension OrderCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getItemViewCellHeight()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.output.getHeightSectionView(section: section)
    }
}

extension OrderCartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfOrderCart(tableView, section: section)
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
