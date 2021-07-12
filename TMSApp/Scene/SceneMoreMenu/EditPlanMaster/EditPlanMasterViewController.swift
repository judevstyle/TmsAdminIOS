//
//  EditPlanMasterViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import UIKit

class EditPlanMasterViewController: UIViewController {
    
    
    //MARK:- EditUpdateView
    @IBOutlet var stackViewEditUpdate: UIStackView!
    @IBOutlet var inputPlanName: InputTextFieldView!
    @IBOutlet var inputPlanDesc: InputTextArea!
    @IBOutlet var inputNumberTruck: InputTextFieldPickerView!
    @IBOutlet var inputTypePlan: InputRadioGroupView!
    @IBOutlet var buttonSave: ButtonPrimaryView!
    
    
    //MARK:- DetailView
    @IBOutlet var planNameText: UILabel!
    @IBOutlet var planDescText: UILabel!
    @IBOutlet var planTruckTableView: UITableView!
    @IBOutlet var planTruckTableViewHeight: NSLayoutConstraint!
    @IBOutlet var planTypeText: UILabel!
    
    @IBOutlet var planNameView: UIView!
    @IBOutlet var planDescView: UIView!
    @IBOutlet var planTruckView: UIView!
    @IBOutlet var planTypeView: UIView!
    
    
    //MARK:- ShareView
    @IBOutlet var dayCollectionView: DayCollectionView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    
    let pickerTypeView = ToolbarPickerView()
    let typeList = ["ทะเบียน 00000", "ทะเบียน 11111"]
    var selectedType : String?
    
    lazy var viewModel: EditPlanMasterProtocol = {
        let vm = EditPlanMasterViewModel(editPlanMasterViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        registerCell()
        tableViewHeight.constant = 0
        registerTruckCell()
        
        if viewModel.output.getViewEditing() {
            
        } else {
            viewModel.input.getPlanMasterDetail()
        }
    }
    
    func configure(_ interface: EditPlanMasterProtocol) {
        self.viewModel = interface
    }
    
}

// MARK: - Binding
extension EditPlanMasterViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetEmployeeSuccess = didGetEmployeeSuccess()
        viewModel.output.didGetShopSuccess = didGetShopSuccess()
        viewModel.output.didGetTruckSuccess = didGetTruckSuccess()
    }
    
    func didGetEmployeeSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableViewHeight.constant = 0
            weakSelf.tableView.reloadData()
            
        }
    }
    
    func didGetShopSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableViewHeight.constant = 0
            weakSelf.tableView.reloadData()
        }
    }
    
    func didGetTruckSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.planTruckTableViewHeight.constant = 0
            weakSelf.planTruckTableView.reloadData()
        }
    }
}

// MARK: - SETUP UI
extension EditPlanMasterViewController {
    func setupUI() {
        inputPlanName.inputText.delegate = self
        inputPlanName.titleLabel.text = "ชื่อแผนการทำงาน"
        inputPlanDesc.titleLabel.text = "รายละเอียดแผนการทำงาน"
        inputNumberTruck.titleLabel.text = "รถขนส่ง"
        inputTypePlan.titleLabel.text = "ประเภทแผนการทำงาน"
        
        
        inputTypePlan.setupRadio(listRadio: ["วันธรรมดา", "วันพิเศษ"])
        inputTypePlan.delegate = self
        
        buttonSave.setTitle(title: "บันทึก")
        buttonSave.delegate = self
        
        let days: [WeeklyType] = [.Monday, .Tuesday, .Wednesday, .Thursday, .Friday, .Saturday, .Sunday]
        dayCollectionView.viewModel.input.setList(days: days)
        dayCollectionView.viewModel.input.setDelegate(delegate: self)
        dayCollectionView.viewModel.input.setEdit(isEdit: viewModel.output.getViewEditing())
        
        setupDelegatesTypePickerView()
        
        if viewModel.output.getViewEditing() == true {
            self.planNameView.isHidden = true
            self.planDescView.isHidden = true
            self.planTruckView.isHidden = true
            self.planTypeView.isHidden = true
        } else {
            self.inputPlanName.isHidden = true
            self.inputPlanDesc.isHidden = true
            self.inputNumberTruck.isHidden = true
            self.inputTypePlan.isHidden = true
            self.buttonSave.isHidden = true
            self.inputPlanDesc.isHidden = true
        }
        
        if viewModel.output.getViewEditing() {
        } else {
            viewModel.input.getEmployee()
            viewModel.input.getShop()
            viewModel.input.getTruck()
        }
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.register(HeaderPrimaryBottomLineTableViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderPrimaryBottomLineTableViewCell.identifier)
        tableView.registerCell(identifier: EmployeeTableViewCell.identifier)
        tableView.registerCell(identifier: EmptyTableViewCell.identifier)
        tableView.registerCell(identifier: ShopTableViewCell.identifier)
        tableView.registerCell(identifier: TruckTableViewCell.identifier)
    }
    
    fileprivate func registerTruckCell() {
        planTruckTableView.delegate = self
        planTruckTableView.dataSource = self
        planTruckTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        planTruckTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        planTruckTableView.separatorStyle = .none
        planTruckTableView.registerCell(identifier: TruckTableViewCell.identifier)
        planTruckTableView.registerCell(identifier: EmptyTableViewCell.identifier)
    }
    
    func setupDelegatesTypePickerView() {
        
        inputNumberTruck.inputText.delegate = self
        inputNumberTruck.inputText.inputView = pickerTypeView
        inputNumberTruck.inputText.inputAccessoryView = pickerTypeView.toolbar
        
        pickerTypeView.dataSource = self
        pickerTypeView.delegate = self
        pickerTypeView.toolbarDelegate = self
    }
}

// MARK: - Handles
extension EditPlanMasterViewController {
    @objc func btnPlanAction() {
        NavigationManager.instance.pushVC(to: .editPlanMaster(planId: nil, isEdit: true))
    }
}

extension EditPlanMasterViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.typeList.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.typeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedType = self.typeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.PrimaryText(size: 18)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = self.typeList[row]
        return pickerLabel!
    }
}

extension EditPlanMasterViewController: ToolbarPickerViewDelegate {
    
    func didTapDone() {
        self.inputNumberTruck.inputText.text = self.selectedType ?? ""
        self.view.endEditing(true)
    }
    
    func didTapCancel() {
        self.view.endEditing(true)
    }
}

extension EditPlanMasterViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.tableView {
            tableViewHeight.constant = 0
            tableViewHeight.constant += 16
            tableViewHeight.constant += 50
            return 2
        } else {
            planTruckTableViewHeight.constant = 0
            planTruckTableViewHeight.constant += 8
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView {
            return viewModel.output.getHeightForRowAt(tableView, section: indexPath.section, type: .EmployeeShopTableView)
        } else {
            return viewModel.output.getHeightForRowAt(tableView, section: indexPath.section, type: .TruckTableView)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tableView == self.tableView {
            return viewModel.output.getHeightSectionView(section: section, type: .EmployeeShopTableView)
        } else {
            return viewModel.output.getHeightSectionView(section: section, type: .TruckTableView)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}

extension EditPlanMasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            let count = viewModel.output.getNumberOfRowsInSection(tableView, section: section, type: .EmployeeShopTableView)
            tableViewHeight.constant += (CGFloat(count) * viewModel.output.getHeightForRowAt(tableView, section: section, type: .EmployeeShopTableView))
            return count
        } else {
            let count = viewModel.output.getNumberOfRowsInSection(tableView, section: section, type: .TruckTableView)
            planTruckTableViewHeight.constant += (CGFloat(count) * viewModel.output.getHeightForRowAt(tableView, section: section, type: .TruckTableView))
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath, type: .EmployeeShopTableView)
        } else {
            return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath, type: .TruckTableView)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == self.tableView {
            return viewModel.output.getHeaderViewCell(tableView, section: section, type: .EmployeeShopTableView)
        } else {
            return viewModel.output.getHeaderViewCell(tableView, section: section, type: .TruckTableView)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension EditPlanMasterViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}

extension EditPlanMasterViewController: ButtonPrimaryViewDelegate {
    func onClickButton() {
        print("onClickButton")
    }
}

extension EditPlanMasterViewController: InputRadioGroupViewDelegate {
    func didSelectRadio(value: String, index: Int) {
        print(value)
        print(index)
    }
}

extension EditPlanMasterViewController: DayCollectionViewModelDelegate {
    func listSelectedDay(days: [WeeklyType]?) {
        print(days)
    }
}
