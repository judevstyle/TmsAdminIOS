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
    
    fileprivate var imageBase64: String?
    
    
    // ViewModel
    lazy var viewModel: EditTruckProtocol = {
        let vm = EditTruckViewModel(editTruckViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func configure(_ interface: EditTruckProtocol) {
        self.viewModel = interface
    }
}

// MARK: - Binding
extension EditTruckViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetTruckSuccess = didGetTruckSuccess()
        viewModel.output.didGetTruckError = didGetTruckError()
    }
    
    func didGetTruckSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
        }
    }
    
    func didGetTruckError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
        }
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
        guard let registrationNumber = self.inputNumberTruck.inputText.text, registrationNumber != "",
              let truckTitle = self.inputBrandTruck.inputText.text, truckTitle != "",
              let truckDesc = self.descTruck.inputText.text, truckDesc != "",
              let base64 = self.imageBase64, base64.isEmpty == false
        else { return }
        
        viewModel.input.createTruck(truckTitle: truckTitle,
                                    truckDesc: truckDesc,
                                    registrationNumber: registrationNumber,
                                    productImg: base64)
    }
}

extension EditTruckViewController : ImageChoose1x1ButtonDelegate {
    func didSelectImage(base64: String) {
        self.imageBase64 = base64
    }
}
