//
//  EditCollectibleViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/20/21.
//

import UIKit

class EditCollectibleViewController: UIViewController {

    @IBOutlet var imagePicker: ImageChoose1x1ButtonView!
    
    @IBOutlet var inputNameView: InputTextFieldView!
    @IBOutlet var inputDescView: InputTextArea!
    
    @IBOutlet var inputPointUseView: InputTextFieldView!
    @IBOutlet var inputAllSumView: InputTextFieldView!
    
    @IBOutlet var inputDateStart: InputTextFieldDatePicker!
    
    @IBOutlet var inputDateEnd: InputTextFieldDatePicker!
    
    @IBOutlet var buttonSave: ButtonPrimaryView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

extension EditCollectibleViewController {
    func setupUI() {
        
        inputNameView.inputText.delegate = self
        
        inputPointUseView.inputText.delegate = self
        inputAllSumView.inputText.delegate = self
        
        inputDateStart.inputText.delegate = self
        inputDateEnd.inputText.delegate = self
        
        inputNameView.titleLabel.text = "ชื่อของสะสม"
        inputDescView.titleLabel.text = "รายละเอียด"
        inputPointUseView.titleLabel.text = "คะแนนที่ต้องใช้"
        inputAllSumView.titleLabel.text = "จำนวนสิทธิ์"

        inputDateStart.titleLabel.text = "วันจัดแคมเปญ"
        inputDateEnd.titleLabel.text = ""

        
        buttonSave.setTitle(title: "บันทึก")
        buttonSave.delegate = self
        
        
        imagePicker.setupImagePicker(vc: self)
        
        self.inputDateStart.inputText.setInputViewDatePicker(target: self, selector: #selector(tapDoneStartDatePicker))
        self.inputDateEnd.inputText.setInputViewDatePicker(target: self, selector: #selector(tapDoneEndDatePicker))
    }
    
    @objc func tapDoneStartDatePicker() {
        if let datePicker = self.inputDateStart.inputText.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "dd/MM/yyyy"
            self.inputDateStart.inputText.text = dateformatter.string(from: datePicker.date)
        }
        self.inputDateStart.inputText.resignFirstResponder()
    }
    
    @objc func tapDoneEndDatePicker() {
        if let datePicker = self.inputDateEnd.inputText.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "dd/MM/yyyy"
            self.inputDateEnd.inputText.text = dateformatter.string(from: datePicker.date)
        }
        self.inputDateEnd.inputText.resignFirstResponder()
    }
}

extension EditCollectibleViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}

extension EditCollectibleViewController: ButtonPrimaryViewDelegate {
    func onClickButton() {
        print("onClickButton")
    }
}
