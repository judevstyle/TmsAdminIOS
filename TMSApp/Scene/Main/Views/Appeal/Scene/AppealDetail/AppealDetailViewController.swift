//
//  AppealDetailViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/2/21.
//

import UIKit

class AppealDetailViewController: UIViewController {
    
    @IBOutlet weak var topDetailView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    // ViewModel
    lazy var viewModel: AppealDetailProtocol = {
        let vm = AppealDetailViewModel(appealDetailViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
    }
    
    func configure(_ interface: AppealDetailProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.getAppeal(request: GetAppealRequest(title: ""))
    }
    
}

// MARK: - Binding
extension AppealDetailViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetAppealSuccess = didGetAppealSuccess()
        viewModel.output.didGetAppealError = didGetAppealError()
    }
    
    func didGetAppealSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
    
    func didGetAppealError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

extension AppealDetailViewController {
    func setupUI(){
        topDetailView.roundCorners(corners: .bottomLeft, radius: 25)
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.register(MainDashBoardHeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: MainDashBoardHeaderTableViewCell.identifier)
        tableViewRegister(identifier: AppealSentByTableViewCell.identifier)
        tableViewRegister(identifier: AppealFeedbackTableViewCell.identifier)
    }
    
    fileprivate func tableViewRegister(identifier: String) {
        self.tableView.register(UINib.init(nibName: identifier, bundle: Bundle.main), forCellReuseIdentifier: identifier)
    }
}

extension AppealDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let itemAppeal = viewModel.output.getItemAppeal(index: indexPath.item) else { return }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getItemViewCellHeight(section: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.output.getHeightSectionView(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    
}


extension AppealDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfAppeal(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getItemViewCell(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel.output.getHeaderViewCell(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

