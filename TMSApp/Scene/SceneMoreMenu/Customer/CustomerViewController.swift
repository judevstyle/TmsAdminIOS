//
//  CustomerViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class CustomerViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnAddCustomer: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI() 
    }

}
// MARK: - SETUP UI
extension CustomerViewController {
    func setupUI() {
        btnAddCustomer.setRounded(rounded: 8)
        btnAddCustomer.addTarget(self, action: #selector(btnAddCustomerAction), for: .touchUpInside)
    }
    
    fileprivate func registerCell() {
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: ProductTableViewCell.identifier)
    }
    
}

// MARK: - Handles
extension CustomerViewController {
    @objc func btnAddCustomerAction() {
//        NavigationManager.instance.pushVC(to: .editEmployee)
    }
}
