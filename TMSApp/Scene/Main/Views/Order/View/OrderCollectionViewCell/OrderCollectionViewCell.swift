//
//  OrderCollectionViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/26/21.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OrderCollectionViewCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    // ViewModel
    lazy var viewModel: OrderCollectionProtocol = {
        let vm = OrderCollectionViewModel(orderCollectionViewCell: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    var listOrder: [GetOrderResponse]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.viewModel.input.fetchOrder(weakSelf.listOrder)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        registerCell()
    }
    
    func configure(_ interface: OrderCollectionProtocol) {
        self.viewModel = interface
    }
    
}


// MARK: - Binding
extension OrderCollectionViewCell {
    
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


extension OrderCollectionViewCell {
    func setupUI(){
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableViewRegister(identifier: OrderTableViewCell.identifier)
    }
    
    fileprivate func tableViewRegister(identifier: String) {
        self.tableView.register(UINib.init(nibName: identifier, bundle: Bundle.main), forCellReuseIdentifier: identifier)
    }
}

extension OrderCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let itemOrder = viewModel.output.getItemOrder(index: indexPath.item) else { return }
        print(itemOrder.title ?? "")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getItemViewCellHeight()
    }
}

extension OrderCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfOrder()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getItemViewCell(tableView, indexPath: indexPath)
    }
}
