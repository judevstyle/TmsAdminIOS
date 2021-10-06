//
//  EditCustomerViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 9/1/21.
//

import UIKit

class EditCustomerViewController: UIViewController {
    
    @IBOutlet var ImageCustomer: ImageChoose1x1ButtonView!
    
    @IBOutlet var inputDisplayName: InputTextFieldView!
    @IBOutlet var inputOwnerName: InputTextFieldView!
    @IBOutlet var inputDescCustomer: InputTextArea!
    @IBOutlet var inputTel: InputTextFieldView!
    @IBOutlet var inputAddress: InputTextArea!
    @IBOutlet var inputTypeCustomer: InputTextFieldPickerView!
    
    @IBOutlet weak var viewKeyboardHeight: NSLayoutConstraint!
    
    @IBOutlet var buttonSave: ButtonPrimaryView!
    
    let pickerTypeView = ToolbarPickerView()
    var typeList: [String] = []
    var selectedType : String?
    
    fileprivate var imageBase64: String?
    
    // ViewModel
    lazy var viewModel: EditCustomerProtocol = {
        let vm = EditCustomerViewModel(editCustomerViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        registerKeyboardObserver()
        viewModel.input.getCustomerType()
    }
    
    deinit {
       removeObserver()
    }

    func configure(_ interface: EditCustomerProtocol) {
        self.viewModel = interface
    }
    
}

// MARK: - Binding
extension EditCustomerViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetCustomerTypeSuccess = didGetCustomerTypeSuccess()
    }

    func didGetCustomerTypeSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.setValueProductType()
        }
    }

}

extension EditCustomerViewController {
    func setupUI() {
        
        inputDisplayName.inputText.delegate = self
        inputOwnerName.inputText.delegate = self
        inputTel.inputText.delegate = self
        
        ImageCustomer.setupImagePicker(vc: self, delegate: self)
        
        inputDisplayName.titleLabel.text = "ชื่อที่แสดง"
        inputOwnerName.titleLabel.text = "ชื่อเจ้าของร้าน"
        inputDescCustomer.titleLabel.text = "รายละเอียดร้านค้า"
        inputTel.titleLabel.text = "เบอร์โทร"
        inputAddress.titleLabel.text = "ที่อยู่"
        inputTypeCustomer.titleLabel.text = "ประเภทลูกค้า"
        
        buttonSave.setTitle(title: "บันทึก")
        buttonSave.delegate = self
    }
    
    func setupDelegatesTypePickerView() {
        
        inputTypeCustomer.inputText.delegate = self
        inputTypeCustomer.inputText.inputView = pickerTypeView
        inputTypeCustomer.inputText.inputAccessoryView = pickerTypeView.toolbar
        
        pickerTypeView.dataSource = self
        pickerTypeView.delegate = self
        pickerTypeView.toolbarDelegate = self
    }
    
    func setValueProductType() {
        guard let list = viewModel.output.getListCustomerType() else { return }
        typeList.removeAll()
        for item in list {
            typeList.append(item.typeName ?? "")
        }
        
        if typeList.count != 0 {
            inputTypeCustomer.inputText.text = typeList[0]
            self.selectedType =  typeList[0]
        }
        setupDelegatesTypePickerView()
    }
    
}

extension EditCustomerViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}

extension EditCustomerViewController: ButtonPrimaryViewDelegate {
    func onClickButton() {
        print("onClickButton")
//        guard let productName = self.inputProductName.inputText.text, productName != "",
//              let productDesc = self.descProduct.inputText.text, productDesc != "",
//              let productDimension = self.descSizeProduct.inputText.text, productDimension != "",
//              let productPrice = self.inputPriceProduct.inputText.text, productPrice != "",
//              let productPoint = self.inputPriceProduct.inputText.text, productPoint != "",
//              let productCountPerPoint = self.inputUnitProduct.inputText.text, productCountPerPoint != "",
//              let productTypeName = self.inputTypeProduct.inputText.text, productTypeName != "",
//              let base64 = self.imageBase64, base64.isEmpty == false
//        else { return }
//
//
//        viewModel.input.createProduct(productCode: "CODE",
//                                      productName: productName,
//                                      productDesc: productDesc,
//                                      productDimension: productDimension,
//                                      productPrice: Double(productPrice) ?? 0.0,
//                                      productPoint: Int(productPoint) ?? 0,
//                                      productCountPerPoint: Int(productCountPerPoint) ?? 0,
//                                      productImg: base64,
//                                      productTypeName: productTypeName)
    }
}

extension EditCustomerViewController : UIPickerViewDelegate, UIPickerViewDataSource {
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
        if self.typeList.count != 0 {
            self.selectedType = self.typeList[row]
        }
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

extension EditCustomerViewController: ToolbarPickerViewDelegate {
    
    func didTapDone() {
        self.inputTypeCustomer.inputText.text = self.selectedType ?? ""
        self.view.endEditing(true)
    }
    
    func didTapCancel() {
        self.view.endEditing(true)
    }
}


extension EditCustomerViewController : KeyboardListener {
    func keyboardDidUpdate(keyboardHeight: CGFloat) {
        viewKeyboardHeight.constant = keyboardHeight
    }
}


extension EditCustomerViewController: ImageChoose1x1ButtonDelegate {
    func didSelectImage(base64: String) {
        self.imageBase64 = base64
    }
}
