//
//  CollectibleViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/20/21.
//

import UIKit

class CollectibleViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnCollectible: ButtonPrimaryView!
    
    // ViewModel
    lazy var viewModel: CollectibleProtocol = {
        let vm = CollectibleViewModel(CollectibleViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        viewModel.input.getCollectible()
    }
    
    func configure(_ interface: CollectibleProtocol) {
        self.viewModel = interface
    }
}

// MARK: - Binding
extension CollectibleViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetCollectibleSuccess = didGetCollectibleSuccess()
        viewModel.output.didGetCollectibleError = didGetCollectibleError()
    }
    
    func didGetCollectibleSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
    
    func didGetCollectibleError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

// MARK: - SETUP UI
extension CollectibleViewController {
    func setupUI() {
        btnCollectible.setTitle(title: "เพิ่มของสะสม")
        btnCollectible.delegate = self
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: CollectibleTableViewCell.identifier)
    }
    
}

// MARK: - Handles
extension CollectibleViewController: ButtonPrimaryViewDelegate {
    func onClickButton() {
        NavigationManager.instance.pushVC(to: .editCollectible)
    }
}


extension CollectibleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NavigationManager.instance.pushVC(to: .coleectibleDetail)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}


extension CollectibleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
    }
}
