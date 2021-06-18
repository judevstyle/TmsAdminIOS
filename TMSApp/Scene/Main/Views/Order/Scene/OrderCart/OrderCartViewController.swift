//
//  OrderCartViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/30/21.
//

import UIKit

class OrderCartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var overallView: UIView!
    
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
        self.showAlertComfirm(titleText: "คุณต้องการยืนยันการสั่งออร์เดอร์ หรือไม่ ?", messageText: "", dismissAction: {
            print("dismissAction")
        }, confirmAction: {
            print("confirmAction")
            self.navigationController?.popViewController(animated: true)
        })
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
