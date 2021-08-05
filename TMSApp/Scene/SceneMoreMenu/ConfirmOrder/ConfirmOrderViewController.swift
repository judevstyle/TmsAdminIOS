//
//  ConfirmOrderViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/4/21.
//

import UIKit

class ConfirmOrderViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var btnAddProduct: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        viewModel.input.fetchOrderCart()
    }
}

// MARK: - Binding
extension ConfirmOrderViewController {
    
}

extension ConfirmOrderViewController {
    func setupUI(){
        btnAddProduct.setRounded(rounded: 8)
        btnAddProduct.layer.borderWidth = 1
        btnAddProduct.layer.borderColor = UIColor.Primary.cgColor
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: ConfirmOrderTableViewCell.identifier)
    }
    
    func setupValue() {

    }
}

extension ConfirmOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
}

extension ConfirmOrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConfirmOrderTableViewCell.identifier, for: indexPath) as! ConfirmOrderTableViewCell
        cell.selectionStyle = .none
//        cell.items = self.listOrderCart?[indexPath.item]
        return cell
    }
}
