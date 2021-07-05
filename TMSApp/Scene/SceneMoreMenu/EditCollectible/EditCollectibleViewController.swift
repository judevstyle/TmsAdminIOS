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
    
    // ViewModel
    lazy var viewModel: EditCollectibleProtocol = {
        let vm = EditCollectibleViewModel(editCollectibleViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    fileprivate var imageBase64: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func configure(_ interface: EditCollectibleProtocol) {
        self.viewModel = interface
    }

}

// MARK: - Binding
extension EditCollectibleViewController {
    
    func bindToViewModel() {
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
        
        
        imagePicker.setupImagePicker(vc: self, delegate: self)
        
        self.inputDateStart.inputText.setInputViewDatePicker(target: self, selector: #selector(tapDoneStartDatePicker))
        self.inputDateEnd.inputText.setInputViewDatePicker(target: self, selector: #selector(tapDoneEndDatePicker))
    }
    
    @objc func tapDoneStartDatePicker() {
        if let datePicker = self.inputDateStart.inputText.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "dd/MM/yyyy"
            self.inputDateStart.inputText.text = dateformatter.string(from: datePicker.date)
            
            self.inputDateEnd.inputText.setInputViewDatePicker(target: self, selector: #selector(tapDoneEndDatePicker), dateStart: datePicker.date, isEnableMinDate: true)
            self.inputDateEnd.inputText.text = ""
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

        guard let clbTitle = self.inputNameView.inputText.text, clbTitle != "",
              let clbDescript = self.inputDescView.inputText.text, clbDescript != "",
              let rewardPoint = self.inputPointUseView.inputText.text, rewardPoint != "",
              let qty = self.inputAllSumView.inputText.text, qty != "",
              let campaignStartDate = self.inputDateStart.inputText.text, campaignStartDate != "",
              let campaignEndDate = self.inputDateEnd.inputText.text, campaignEndDate != "",
              let base64 = self.imageBase64, base64.isEmpty == false
        else { return }
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        let startDate = dateformatter.string(from: dateformatter.date(from: campaignStartDate) ?? Date())
        let endDate = dateformatter.string(from: dateformatter.date(from: campaignEndDate) ?? Date())
        
        viewModel.input.createCollectible(clbTitle: clbTitle,
                                          clbDescript: clbDescript,
                                          qty: qty,
                                          clbImg: base64,
                                          rewardPoint: rewardPoint,
                                          campaignStartDate: startDate,
                                          campaignEndDate: endDate)
    }
}

extension EditCollectibleViewController : ImageChoose1x1ButtonDelegate {
    func didSelectImage(base64: String) {
        self.imageBase64 = base64
    }
}
