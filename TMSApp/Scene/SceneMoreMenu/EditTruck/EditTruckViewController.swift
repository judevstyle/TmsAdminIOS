//
//  EditTruckViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import UIKit

class EditTruckViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var inputNumberTruck: InputTextFieldView!
    @IBOutlet weak var inputBrandTruck: InputTextFieldView!
    @IBOutlet weak var descTruck: InputTextArea!
    
    @IBOutlet var buttonSave: ButtonPrimaryView!
    
    @IBOutlet var imagePicker: ImageChoose1x1ButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}


extension EditTruckViewController {
    func setupUI() {
        
        inputNumberTruck.inputText.delegate = self
        inputBrandTruck.inputText.delegate = self
        
        imagePicker.setupImagePicker(vc: self, delegate: self)
        
        inputNumberTruck.titleLabel.text = "เลขทะเบียนรถ"
        inputBrandTruck.titleLabel.text = "ยี่ห้อรถ"
        descTruck.titleLabel.text = "รายละเอียดรถ"
        
        buttonSave.setTitle(title: "บันทึก")
        buttonSave.delegate = self
    }
    
    
}

extension EditTruckViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}

extension EditTruckViewController: ButtonPrimaryViewDelegate {
    func onClickButton() {
        print("onClickButton")
    }
}

extension EditTruckViewController : ImageChoose1x1ButtonDelegate {
    func didSelectImage(base64: String) {
        print(base64)
    }
}
