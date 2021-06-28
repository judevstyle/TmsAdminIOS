//
//  EditAssetViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import UIKit

class EditAssetViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var inputName: InputTextFieldView!
    @IBOutlet weak var inputDesc: InputTextArea!
    @IBOutlet weak var inputUnit: InputTextFieldView!
    
    @IBOutlet var buttonSave: ButtonPrimaryView!
    
    @IBOutlet var imagePicker: ImageChoose1x1ButtonView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}


extension EditAssetViewController {
    func setupUI() {
        
        inputName.inputText.delegate = self
        inputUnit.inputText.delegate = self
        
        imagePicker.setupImagePicker(vc: self, delegate: self)
        
        inputName.titleLabel.text = "ชื่อ"
        inputDesc.titleLabel.text = "รายละเอียด"
        inputUnit.titleLabel.text = "หน่วย"
        
        buttonSave.setTitle(title: "บันทึก")
        buttonSave.delegate = self
    }
    
    
}

extension EditAssetViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}

extension EditAssetViewController: ButtonPrimaryViewDelegate {
    func onClickButton() {
        print("onClickButton")
    }
}

extension EditAssetViewController : ImageChoose1x1ButtonDelegate {
    func didSelectImage(base64: String) {
    }
}
