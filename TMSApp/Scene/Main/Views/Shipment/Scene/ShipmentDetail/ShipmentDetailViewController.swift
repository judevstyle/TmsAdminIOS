//
//  ShipmentDetailViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/18/21.
//

import UIKit
import Charts

class ShipmentDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnAddShipment: UIButton!
    
    @IBOutlet weak var dataShipmentView: UIView!
    @IBOutlet weak var dataCarView: UIView!
    @IBOutlet weak var dataCashView: UIView!
    @IBOutlet weak var dataChartView: UIView!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    
    @IBOutlet weak var shipmentNoText: UILabel!
    @IBOutlet weak var customerCountText: UILabel!
    @IBOutlet weak var truckNo: UILabel!
    
    @IBOutlet weak var sumPay: UILabel!
    @IBOutlet weak var sumOverduePay: UILabel!
    
    @IBOutlet weak var planNameText: UILabel!
    @IBOutlet weak var toSendText: UILabel!
    @IBOutlet weak var sendSuccessText: UILabel!
    @IBOutlet weak var sendWaitText: UILabel!
    @IBOutlet weak var sendFailText: UILabel!
    
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
        setupPieChart()
    }
    
    func configure(_ interface: ShipmentDetailProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.getShipment()
    }
    @IBAction func btnShipmentAction(_ sender: Any) {
        NavigationManager.instance.pushVC(to: .sequenceShipment)
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
            
//            weakSelf.tableView.reloadData()
            weakSelf.setupValue()
        }
    }
    
    func didGetShipmentDetailError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
//            weakSelf.tableView.reloadData()
        }
    }
}

extension ShipmentDetailViewController {
    func setupValue() {
        shipmentNoText.text = "รหัส Shipment #\(viewModel.output.getCodeShipment())"
        customerCountText.text = "จำนวนลูกค้า\(viewModel.output.getCountCustomer())"
        truckNo.text = viewModel.output.getCarInfo()
        
        sumPay.text = "0"
        sumOverduePay.text = "0"
        
        planNameText.text = "แผนการทำงาน : \(viewModel.output.getPlanName())"
        
        toSendText.text = "\(viewModel.output.getSummaryCustomer()?.totalCustomer ?? 0)"
        sendSuccessText.text = "\(viewModel.output.getSummaryCustomer()?.totalSended ?? 0)"
        sendWaitText.text = "\(viewModel.output.getSummaryCustomer()?.totalToSend ?? 0)"
        sendFailText.text = "\(viewModel.output.getSummaryCustomer()?.totalSendNotSuccess ?? 0)"
        
        setupPieChart(summary: viewModel.output.getSummaryCustomer())
        
    }
    
    func setupUI(){
        
        dataShipmentView.setShadowBoxView()
        dataShipmentView.setRounded(rounded: 8)
        
        dataCarView.setShadowBoxView()
        dataCarView.setRounded(rounded: 8)
        
        dataCashView.setShadowBoxView()
        dataCashView.setRounded(rounded: 8)
        
        dataChartView.setShadowBoxView()
        dataChartView.setRounded(rounded: 8)
        
        btnAddShipment.setRounded(rounded: 8)
    }
    
    func setupPieChart(summary: SummaryCustomer? = nil) {
        pieChartView.chartDescription?.enabled = false
        pieChartView.drawHoleEnabled = true
        pieChartView.rotationAngle = 0.5
        pieChartView.rotationEnabled = true
        pieChartView.isUserInteractionEnabled = true
        
        pieChartView.holeRadiusPercent = 0.65
        pieChartView.transparentCircleRadiusPercent = 0
        pieChartView.minOffset = 0
        pieChartView.centerText = "Report"
        
        var entries: [PieChartDataEntry] = Array()
        
        if let summary = summary {
            entries.append(PieChartDataEntry(value: Double(summary.totalCustomer), label: ""))
            entries.append(PieChartDataEntry(value: Double(summary.totalSended), label: ""))
            entries.append(PieChartDataEntry(value: Double(summary.totalToSend), label: ""))
            entries.append(PieChartDataEntry(value: Double(summary.totalSendNotSuccess), label: "Global Data"))
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        
        let c1 = NSUIColor(cgColor: UIColor.systemBlue.cgColor)
        let c2 = NSUIColor(cgColor: UIColor.systemGreen.cgColor)
        let c3 = NSUIColor(cgColor: UIColor.systemIndigo.cgColor)
        let c4 = NSUIColor(cgColor: UIColor.systemPink.cgColor)
        
        dataSet.colors = [c1, c2, c3, c4]
        dataSet.sliceSpace = 3
        dataSet.drawValuesEnabled = false
        dataSet.selectionShift = 3
        pieChartView.drawEntryLabelsEnabled = false
        
        pieChartView.data = PieChartData(dataSet: dataSet)
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
        NavigationManager.instance.pushVC(to: .shipmentMap, presentation: .Push)
    }
}
