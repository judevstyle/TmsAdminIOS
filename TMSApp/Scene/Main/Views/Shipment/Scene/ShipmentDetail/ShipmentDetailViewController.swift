//
//  ShipmentDetailViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/18/21.
//

import UIKit

class ShipmentDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnAddShipment: UIButton!
    
    
    // ViewModel
    lazy var viewModel: ShipmentDetailProtocol = {
        let vm = ShipmentDetailViewModel(shipmentDetailViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
    
        NavigationManager.instance.setupWithNavigationController(navigationController: self.navigationController)
    }
    
    func configure(_ interface: ShipmentDetailProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.getShipment()
    }
}

// MARK: - Binding
extension ShipmentDetailViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetShipmentDetailSuccess = didGetShipmentDetailSuccess()
        viewModel.output.didGetShipmentDetailError = didGetShipmentDetailError()
    }
    
    func didGetShipmentDetailSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            
            weakSelf.tableView.reloadData()
        }
    }
    
    func didGetShipmentDetailError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

extension ShipmentDetailViewController {
    func setupUI(){
        btnAddShipment.setRounded(rounded: 8)
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.register(HeaderShipmentDetailTableViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderShipmentDetailTableViewCell.identifier)
        tableViewRegister(identifier: DeliveryShipmentTableViewCell.identifier)
        tableViewRegister(identifier: EmployeeShipmentTableViewCell.identifier)
        tableViewRegister(identifier: CustomerShipmentTableViewCell.identifier)
    }
    
    fileprivate func tableViewRegister(identifier: String) {
        self.tableView.register(UINib.init(nibName: identifier, bundle: Bundle.main), forCellReuseIdentifier: identifier)
    }
}

extension ShipmentDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return viewModel.input.didSelectRowAt(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightTableViewCell(section: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.output.getHeightSectionView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let height = (viewModel.output.getHeightSectionView() * CGFloat(viewModel.output.getSectionOfShipmentDetail()))
        tableViewHeight.constant = 100
        tableViewHeight.constant = tableViewHeight.constant + CGFloat(height)
        return viewModel.output.getSectionOfShipmentDetail()
    }
}

extension ShipmentDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let height = viewModel.getHeightTableViewCell(section: section) * CGFloat(viewModel.output.getNumberOfShipment(section: section))
        tableViewHeight.constant = tableViewHeight.constant + height
        return viewModel.output.getNumberOfShipment(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getItemViewCell(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderShipmentDetailTableViewCell.identifier)
        if let header = header as? HeaderShipmentDetailTableViewCell {
            header.render(title: viewModel.output.getTitleSectionOfShipmentDetail(section: section), type: viewModel.output.getTypeSectionOfShipmentDetail(section: section))
            header.delegate = self
        }
        return header
    }
}


extension ShipmentDetailViewController: HeaderShipmentDetailTableViewCellDelegate {
    func didTapMapButton() {
        NavigationManager.instance.pushVC(vc: .shipmentMap, presentation: .Push)
    }
}
