//
//  ShipmentDetailViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/13/21.
//

import UIKit
import Charts

class ShipmentDetailViewCell: UICollectionViewCell {
    
    @IBOutlet weak var btnAddShipment: ButtonPrimaryView!
    
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
    
    static let identifier = "ShipmentDetailViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupPieChart()
    }
    
    // ViewModel
    lazy var viewModel: ShipmentDetailProtocol = {
        let vm = ShipmentDetailViewModel(shipmentDetailViewCell: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    

    func configure(_ interface: ShipmentDetailProtocol) {
        self.viewModel = interface
    }

    @IBAction func btnShipmentAction(_ sender: Any) {
        NavigationManager.instance.pushVC(to: .sequenceShipment)
    }
}

// MARK: - Binding
extension ShipmentDetailViewCell {
    
    func bindToViewModel() {
        viewModel.output.didGetShipmentDetailSuccess = didGetShipmentDetailSuccess()
    }
    
    func didGetShipmentDetailSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            
//            weakSelf.tableView.reloadData()
            weakSelf.setupValue()
        }
    }
}

extension ShipmentDetailViewCell {
    func setupValue() {
        shipmentNoText.text = "รหัส Shipment #\(viewModel.output.getCodeShipment())"
        customerCountText.text = "จำนวนลูกค้า \(viewModel.output.getCountCustomer())"
        truckNo.text = viewModel.output.getCarInfo()
        
        sumPay.text = "฿0"
        sumOverduePay.text = "฿0"
        
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
        
        btnAddShipment.setTitle(title: "ลูกค้าที่ต้องจัดส่ง")
        btnAddShipment.delegate = self
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
    
}

extension ShipmentDetailViewCell: ButtonPrimaryViewDelegate {
    func onClickButton() {
        debugPrint("onClick")
    }
}
