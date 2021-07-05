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
    
    fileprivate var imageBase64: String?
    
    // ViewModel
    lazy var viewModel: EditAssetProtocol = {
        let vm = EditAssetViewModel(editAssetViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func configure(_ interface: EditAssetProtocol) {
        self.viewModel = interface
    }
    
}

// MARK: - Binding
extension EditAssetViewController {
    
    func bindToViewModel() {
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
        guard let assetName = self.inputName.inputText.text, assetName != "",
              let assetDesc = self.inputDesc.inputText.text, assetDesc != "",
              let assetUnit = self.inputUnit.inputText.text, assetUnit != "",
              let base64 = self.imageBase64, base64.isEmpty == false
        else { return }
        
        viewModel.input.createAsset(assetName: assetName,
                                    assetDesc: assetDesc,
                                    assetUnit: assetUnit,
                                    assetImg: base64)
    }
}

extension EditAssetViewController : ImageChoose1x1ButtonDelegate {
    func didSelectImage(base64: String) {
        self.imageBase64 = base64
    }
}
