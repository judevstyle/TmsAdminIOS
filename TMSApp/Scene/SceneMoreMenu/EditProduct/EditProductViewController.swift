//
//  EditProductViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import UIKit

class EditProductViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var inputProductBarCode: InputTextFieldView!
    @IBOutlet weak var inputProductName: InputTextFieldView!
    @IBOutlet weak var descProduct: InputTextArea!
    @IBOutlet weak var descSizeProduct: InputTextArea!
    @IBOutlet weak var inputPriceProduct: InputTextFieldView!
    @IBOutlet weak var inputTypeProduct: InputTextFieldPickerView!
    
    @IBOutlet weak var inputUnitProduct: InputTextFieldView!
    @IBOutlet weak var inputPointProduct: InputTextFieldView!
    
    @IBOutlet var buttonSave: ButtonPrimaryView!
    
    @IBOutlet var ImageProduct: ImageChoose1x1ButtonView!
    
    @IBOutlet weak var viewKeyboardHeight: NSLayoutConstraint!
    
    let pickerTypeView = ToolbarPickerView()
    var typeList: [String] = []
    var selectedType : String?
    
    fileprivate var imageBase64: String?
    
    // ViewModel
    lazy var viewModel: EditProductProtocol = {
        let vm = EditProductViewModel(editProductViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        registerKeyboardObserver()
        viewModel.input.getProductType()
    }
    
    deinit {
       removeObserver()
    }

    func configure(_ interface: EditProductProtocol) {
        self.viewModel = interface
    }
    
}

// MARK: - Binding
extension EditProductViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetProductTypeSuccess = didGetProductTypeSuccess()
        viewModel.output.didGetProductTypeError = didGetProductTypeError()
    }
    
    func didGetProductTypeSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.setValueProductType()
        }
    }
    
    func didGetProductTypeError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
        }
    }
}

extension EditProductViewController {
    func setupUI() {
        
        inputProductBarCode.inputText.delegate = self
        inputProductName.inputText.delegate = self
        inputPriceProduct.inputText.delegate = self
        inputUnitProduct.inputText.delegate = self
        inputPointProduct.inputText.delegate = self
        
        ImageProduct.setupImagePicker(vc: self, delegate: self)
        
        inputProductBarCode.titleLabel.text = "Product Barcode"
        inputProductName.titleLabel.text = "ชื่อสินค้า"
        descProduct.titleLabel.text = "รายละเอียดสินค้า"
        descSizeProduct.titleLabel.text = "รายละเอียดขนาดสินค้า"
        inputPriceProduct.titleLabel.text = "ราคา"
        inputTypeProduct.titleLabel.text = "ประเภทสินค้า"
        
        inputUnitProduct.titleLabel.text = "ยอดจำนวนสั่งซื้อ"
        inputPointProduct.titleLabel.text = "รับคะแนน"
        
        inputPriceProduct.inputText.keyboardType = .decimalPad
        inputUnitProduct.inputText.keyboardType = .numberPad
        inputPointProduct.inputText.keyboardType = .numberPad
        
        buttonSave.setTitle(title: "บันทึก")
        buttonSave.delegate = self
    }
    
    func setupDelegatesTypePickerView() {
        
        inputTypeProduct.inputText.delegate = self
        inputTypeProduct.inputText.inputView = pickerTypeView
        inputTypeProduct.inputText.inputAccessoryView = pickerTypeView.toolbar
        
        pickerTypeView.dataSource = self
        pickerTypeView.delegate = self
        pickerTypeView.toolbarDelegate = self
    }
    
    func setValueProductType() {
        guard let list = viewModel.output.getListProductType() else { return }
        typeList.removeAll()
        for item in list {
            typeList.append(item.productTypeName ?? "")
        }
        
        if typeList.count != 0 {
            inputTypeProduct.inputText.text = typeList[0]
            self.selectedType =  typeList[0]
        }
        setupDelegatesTypePickerView()
    }
    
}

extension EditProductViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}

extension EditProductViewController: ButtonPrimaryViewDelegate {
    func onClickButton() {
        print("onClickButton")
        guard let productName = self.inputProductName.inputText.text, productName != "",
              let productDesc = self.descProduct.inputText.text, productDesc != "",
              let productDimension = self.descSizeProduct.inputText.text, productDimension != "",
              let productPrice = self.inputPriceProduct.inputText.text, productPrice != "",
              let productPoint = self.inputPriceProduct.inputText.text, productPoint != "",
              let productCountPerPoint = self.inputUnitProduct.inputText.text, productCountPerPoint != "",
              let productTypeName = self.inputTypeProduct.inputText.text, productTypeName != "",
              let base64 = self.imageBase64, base64.isEmpty == false
        else { return }
        
        
        viewModel.input.createProduct(productCode: "CODE",
                                      productName: productName,
                                      productDesc: productDesc,
                                      productDimension: productDimension,
                                      productPrice: Double(productPrice) ?? 0.0,
                                      productPoint: Int(productPoint) ?? 0,
                                      productCountPerPoint: Int(productCountPerPoint) ?? 0,
                                      productImg: base64,
                                      productTypeName: productTypeName)
    }
}

extension EditProductViewController : UIPickerViewDelegate, UIPickerViewDataSource {
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

extension EditProductViewController: ToolbarPickerViewDelegate {
    
    func didTapDone() {
        self.inputTypeProduct.inputText.text = self.selectedType ?? ""
        self.view.endEditing(true)
    }
    
    func didTapCancel() {
        self.view.endEditing(true)
    }
}


extension EditProductViewController : KeyboardListener {
    func keyboardDidUpdate(keyboardHeight: CGFloat) {
        viewKeyboardHeight.constant = keyboardHeight
    }
}


extension EditProductViewController: ImageChoose1x1ButtonDelegate {
    func didSelectImage(base64: String) {
        self.imageBase64 = base64
    }
}
