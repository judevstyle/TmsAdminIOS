//
//  MainViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/15/21.
//

import UIKit
import Charts
import SocketIO

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var cash: UILabel!
    @IBOutlet weak var debtBalance: UILabel!
    
    @IBOutlet var pieChartView: PieChartView!
    
    @IBOutlet var cashText: UILabel!
    @IBOutlet var creditText: UILabel!
    
    
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
        setupPieChart(cash: 100, credit: 0)
    }
    
    func configure(_ interface: MainProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.getHome()
        NavigationManager.instance.setupWithNavigationController(navigationController: self.navigationController)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.input.fetchDashboard()
    }
    
    @IBAction func tappedMap(_ sender: Any) {
        NavigationManager.instance.pushVC(to: .shipmentMap, presentation: .Push)
//        NavigationManager.instance.pushVC(to: .chat)
    }
}

// MARK: - Binding
extension MainViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetHomeSuccess = didGetHomeSuccess()
        viewModel.output.didGetHomeError = didGetHomeError()
        viewModel.output.didGetDashboardSuccess = didGetDashboardSuccess()
    }
    
    func didGetDashboardSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            guard let data = weakSelf.viewModel.output.getDashboardResponse()?.data else { return }
            weakSelf.cashText.text = "\(data.total_cash ?? 0)"
            weakSelf.creditText.text = "\(data.total_credit ?? 0)"
            weakSelf.setupPieChart(cash: Double(data.total_cash ?? 0), credit: Double(data.total_credit ?? 0))
        }
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
        viewTop.setRounded(rounded: 8)
        viewTop.setShadowBoxView()
    }
    
    func setupPieChart(cash: Double, credit: Double) {
        pieChartView.chartDescription?.enabled = false
        pieChartView.drawHoleEnabled = true
        pieChartView.rotationAngle = 0.5
        pieChartView.rotationEnabled = true
        pieChartView.isUserInteractionEnabled = true
        
        pieChartView.holeRadiusPercent = 0.65
        pieChartView.transparentCircleRadiusPercent = 0
        pieChartView.minOffset = 0
        
        var centerText = NSMutableAttributedString()
        centerText = NSMutableAttributedString(string: "ยอดเงิน" as String, attributes: [NSAttributedString.Key.font:UIFont.PrimaryText(size: 15), NSAttributedString.Key.foregroundColor: UIColor.black])
        pieChartView.centerAttributedText =  centerText
        
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: cash, label: ""))
        entries.append(PieChartDataEntry(value: credit, label: ""))

        let dataSet = PieChartDataSet(entries: entries, label: "Global Data")
        let c1 = NSUIColor(cgColor: UIColor.systemGreen.cgColor)
        let c2 = NSUIColor(cgColor: UIColor.systemRed.cgColor)
        
        dataSet.colors = [c1, c2]
        dataSet.sliceSpace = 3
        dataSet.drawValuesEnabled = false
        dataSet.selectionShift = 3
        
        dataSet.valueTextColor = UIColor.red
        dataSet.valueLineColor = UIColor.red
        dataSet.highlightColor = UIColor.red
        dataSet.entryLabelColor = UIColor.red
        
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.noDataTextColor = .black
        pieChartView.tintColor = .black
        
        pieChartView.data = PieChartData(dataSet: dataSet)
        
        
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
//        tableView.register(HeaderPrimaryBottomLineTableViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderPrimaryBottomLineTableViewCell.identifier)
        tableViewRegister(identifier: MainDashBoardTableViewCell.identifier)
        tableViewRegister(identifier: DashBoardProductTableViewCell.identifier)
        tableViewRegister(identifier: DashBoardWorkingTableViewCell.identifier)
        tableViewRegister(identifier: EmptyTableViewCell.identifier)
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
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getItemViewCell(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel.output.getHeaderViewCell(tableView, section: section)
    }
    
    
}

