//
//  MainViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/15/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var cash: UILabel!
    @IBOutlet weak var debtBalance: UILabel!
    
    // ViewModel
    lazy var viewModel: MainProtocol = {
        let vm = MainViewModel(mainViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
    }
    
    func configure(_ interface: MainProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.getHome()
        NavigationManager.instance.setupWithNavigationController(navigationController: self.navigationController)
    }
    
    @IBAction func tappedMap(_ sender: Any) {
        NavigationManager.instance.pushVC(to: .shipmentMap, presentation: .Push)
    }
}

// MARK: - Binding
extension MainViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetHomeSuccess = didGetHomeSuccess()
        viewModel.output.didGetHomeError = didGetHomeError()
    }
    
    func didGetHomeSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
    
    func didGetHomeError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

extension MainViewController {
    func setupUI(){
        viewTop.setShadowBoxView()
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.register(MainDashBoardHeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: MainDashBoardHeaderTableViewCell.identifier)
        tableViewRegister(identifier: MainDashBoardTableViewCell.identifier)
    }
    
    fileprivate func tableViewRegister(identifier: String) {
        self.tableView.register(UINib.init(nibName: identifier, bundle: Bundle.main), forCellReuseIdentifier: identifier)
    }
}



extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let itemAppeal = viewModel.output.getItemAppeal(index: indexPath.item) else { return }
//        print(itemAppeal.title ?? "")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getItemViewCellHeight(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.output.getHeightSectionView(section: section)
    }
    
}


extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getItemViewCell(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel.output.getHeaderViewCell(tableView, section: section)
    }
    
    
}

