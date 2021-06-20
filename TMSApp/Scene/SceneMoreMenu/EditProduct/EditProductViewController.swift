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
    
    let pickerTypeView = ToolbarPickerView()
    let typeList = ["พนักงานส่งของ", "นักส่งของใหม่"]
    var selectedType : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

extension EditProductViewController {
    func setupUI() {
        
        inputProductBarCode.inputText.delegate = self
        inputProductName.inputText.delegate = self
        inputPriceProduct.inputText.delegate = self
        inputUnitProduct.inputText.delegate = self
        inputPointProduct.inputText.delegate = self
        
        ImageProduct.setupImagePicker(vc: self)
        
        inputProductBarCode.titleLabel.text = "Product Barcode"
        inputProductName.titleLabel.text = "ชื่อสินค้า"
        descProduct.titleLabel.text = "รายละเอียดสินค้า"
        descSizeProduct.titleLabel.text = "รายละเอียดขนาดสินค้า"
        inputPriceProduct.titleLabel.text = "ราคา"
        inputTypeProduct.titleLabel.text = "ประเภทสินค้า"
        
        inputUnitProduct.titleLabel.text = "ยอดจำนวนสั่งซื้อ"
        inputPointProduct.titleLabel.text = "รับคะแนน"
        
        buttonSave.setTitle(title: "บันทึก")
        buttonSave.delegate = self
        setupDelegatesTypePickerView()
    }
    
    func setupDelegatesTypePickerView() {
        
        inputTypeProduct.inputText.delegate = self
        inputTypeProduct.inputText.inputView = pickerTypeView
        inputTypeProduct.inputText.inputAccessoryView = pickerTypeView.toolbar
        
        pickerTypeView.dataSource = self
        pickerTypeView.delegate = self
        pickerTypeView.toolbarDelegate = self
    }
    
    
}

extension EditProductViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}

extension EditProductViewController: ButtonPrimaryViewDelegate {
    func onClickButton() {
        print("onClickButton")
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

extension EditProductViewController: ToolbarPickerViewDelegate {
    
    func didTapDone() {
        self.inputTypeProduct.inputText.text = self.selectedType ?? ""
        self.view.endEditing(true)
    }
    
    func didTapCancel() {
        self.view.endEditing(true)
    }
}
