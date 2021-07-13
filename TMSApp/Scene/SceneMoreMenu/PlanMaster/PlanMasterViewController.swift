//
//  PlanMasterViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class PlanMasterViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnAddPlan: UIButton!
    
    // ViewModel
    lazy var viewModel: PlanMasterProtocol = {
        let vm = PlanMasterViewModel(planMasterViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
    }
    
    func configure(_ interface: PlanMasterProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.getPlanMaster()
    }
}

// MARK: - Binding
extension PlanMasterViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetPlanMasterSuccess = didGetPlanMasterSuccess()
        viewModel.output.didGetPlanMasterError = didGetPlanMasterError()
    }
    
    func didGetPlanMasterSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
    
    func didGetPlanMasterError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

// MARK: - SETUP UI
extension PlanMasterViewController {
    func setupUI() {
        btnAddPlan.setRounded(rounded: 8)
        btnAddPlan.addTarget(self, action: #selector(btnPlanAction), for: .touchUpInside)
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: PlanMasterTableViewCell.identifier)
    }
    
}

// MARK: - Handles
extension PlanMasterViewController {
    @objc func btnPlanAction() {
        NavigationManager.instance.pushVC(to: .editPlanMaster(planId: nil, isEdit: true))
    }
}


extension PlanMasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = viewModel.output.getItemForRowAt(tableView, indexPath: indexPath) else { return }
        NavigationManager.instance.pushVC(to: .editPlanMaster(planId: item.planId, isEdit: false))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}

extension PlanMasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
    }
}
