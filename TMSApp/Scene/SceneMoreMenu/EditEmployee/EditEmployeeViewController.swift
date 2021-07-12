//
//  EditEmployeeViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/13/21.
//

import UIKit

class EditEmployeeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    //Image
    
    @IBOutlet weak var keyboardViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var displayNameView: InputTextFieldView!
    @IBOutlet weak var fristNameView: InputTextFieldView!
    @IBOutlet weak var lastNameView: InputTextFieldView!
    @IBOutlet weak var tel1View: InputTextFieldView!
    @IBOutlet weak var tel2View: InputTextFieldView!
    @IBOutlet var emailView: InputTextFieldView!
    
    @IBOutlet weak var dateView: InputTextFieldDatePicker!
    @IBOutlet weak var addressView: InputTextArea!
    @IBOutlet weak var positionView: InputTextFieldPickerView!
    
    @IBOutlet weak var imageGrid: CollectionViewImageGrid!
    @IBOutlet var buttonSave: ButtonPrimaryView!
    
    let pickerPositionView = ToolbarPickerView()
    var positionList: [String] = []
    var selectedPosition : String?
    
    @IBOutlet var imagePicker: ImageChoose1x1ButtonView!
    
    var imagePickerList: ImagePicker!
    
    fileprivate var imageAvatarBase64: String?
    fileprivate var listImageAttachFilesBase64: [String]?
    
    // ViewModel
    lazy var viewModel: EditEmployeeProtocol = {
        let vm = EditEmployeeViewModel(editEmployeeViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerKeyboardObserver()
        hideKeyboardWhenTappedAround()
        
        viewModel.input.getJobPosition()
        
        self.imagePickerList = ImagePicker(presentationController: self, sourceType: [.camera, .photoLibrary], delegate: self)
    }
    
    deinit {
        removeObserver()
    }
    
    func configure(_ interface: EditEmployeeProtocol) {
        self.viewModel = interface
    }
}

// MARK: - Binding
extension EditEmployeeViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetJobPositionSuccess = didGetJobPositionSuccess()
    }
    
    func didGetJobPositionSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.setValueListPosition()
        }
    }
}


extension EditEmployeeViewController {
    func setupUI() {
        
        imagePicker.setupImagePicker(vc: self, delegate: self)
    
        displayNameView.inputText.delegate = self
        fristNameView.inputText.delegate = self
        lastNameView.inputText.delegate = self
        tel1View.inputText.delegate = self
        tel2View.inputText.delegate = self
        emailView.inputText.delegate = self
        dateView.inputText.delegate = self
        
        imageGrid.viewModel.input.setDelegate(delegate: self)
        imageGrid.viewModel.input.setList(images: [])
        
        displayNameView.titleLabel.text = "ชื่อที่แสดง"
        fristNameView.titleLabel.text = "ชื่อ"
        lastNameView.titleLabel.text = "สกุล"
        tel1View.titleLabel.text = "เบอร์โทร 1"
        tel2View.titleLabel.text = "เบอร์โทร 2"
        emailView.titleLabel.text = "อีเมล์"
        dateView.titleLabel.text = "วันเกิด"
        addressView.titleLabel.text = "ที่อยู่"
        positionView.titleLabel.text = "ตำแหน่ง"
        imageGrid.titleLabel.text = "เอกสารประจำตัว"
        
        buttonSave.setTitle(title: "บันทึก")
        buttonSave.delegate = self
        
        self.dateView.inputText.setInputViewDatePicker(target: self, selector: #selector(tapDoneDatePicker))
    
    }
    
    @objc func tapDoneDatePicker() {
        if let datePicker = self.dateView.inputText.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "dd/MM/yyyy"
            self.dateView.inputText.text = dateformatter.string(from: datePicker.date)
        }
        self.dateView.inputText.resignFirstResponder()
    }
    
    
    func setupDelegatesPostionPickerView() {
        
        positionView.inputText.delegate = self
        positionView.inputText.inputView = pickerPositionView
        positionView.inputText.inputAccessoryView = pickerPositionView.toolbar
        
        pickerPositionView.dataSource = self
        pickerPositionView.delegate = self
        pickerPositionView.toolbarDelegate = self
    }
    
    func setValueListPosition() {
        guard let list = viewModel.output.getListPosition() else { return }
        positionList.removeAll()
        for item in list {
            positionList.append(item.jobPositionName ?? "")
        }
        
        if positionList.count != 0 {
            positionView.inputText.text = positionList[0]
            self.selectedPosition =  positionList[0]
        }
        setupDelegatesPostionPickerView()
    }
    
}


extension EditEmployeeViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == positionView.inputText {
            self.pickerPositionView.reloadAllComponents()
        }
        //        self.scrollToElement(text: textField, scroll: scrollView)
    }
}

extension EditEmployeeViewController {
    func scrollToElement(text: UITextField, scroll: UIScrollView) {
        var point = text.frame.origin
        point.y = point.y - 5
        scroll.setContentOffset(point, animated: true)
    }
}


extension EditEmployeeViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.positionList.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.positionList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedPosition = self.positionList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.PrimaryText(size: 18)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = self.positionList[row]
        return pickerLabel!
    }
}

extension EditEmployeeViewController: ToolbarPickerViewDelegate {
    
    func didTapDone() {
        self.positionView.inputText.text = self.selectedPosition ?? ""
        self.view.endEditing(true)
    }
    
    func didTapCancel() {
        self.view.endEditing(true)
    }
}


extension EditEmployeeViewController: KeyboardListener {
    func keyboardDidUpdate(keyboardHeight: CGFloat) {
        keyboardViewHeight.constant = keyboardHeight
    }
}



extension EditEmployeeViewController: ImagePickerDelegate {
    func didSelectImage(image: UIImage?, imagePicker: ImagePicker, base64: String) {
        imageGrid.viewModel.input.addListImage(image: image ?? UIImage(), base64: base64)
    }
}


extension EditEmployeeViewController : CollectionViewImageGridDelegate {
    func imageListChangeAction(listBase64: [String]?) {
        self.listImageAttachFilesBase64 = listBase64
    }
    
    func didSelectItem(indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.imagePickerList.present(from: self.view)
        }
    }
}


extension EditEmployeeViewController: ButtonPrimaryViewDelegate {
    func onClickButton() {
        guard let empFname = self.displayNameView.inputText.text, empFname != "",
              let empLname = self.lastNameView.inputText.text, empLname != "",
              let empTel1 = self.tel1View.inputText.text, empTel1 != "",
              let empBirthday = self.dateView.inputText.text, empBirthday != "",
              let jobPositionName = self.positionView.inputText.text, jobPositionName != "",
              let empEmail = self.emailView.inputText.text, empEmail != "",
              let empAvatar = self.imageAvatarBase64, empAvatar.isEmpty == false,
              let attachFiles = self.listImageAttachFilesBase64, attachFiles.isEmpty == false
        else { return }
        
        viewModel.input.createEmployee(empFname: empFname,
                                       empLname: empLname,
                                       empBirthday: empBirthday,
                                       empTel1: empTel1,
                                       empAvatar: empAvatar,
                                       attachFiles: attachFiles,
                                       empEmail: empEmail,
                                       jobPositionName: jobPositionName)
    }
}

extension EditEmployeeViewController: ImageChoose1x1ButtonDelegate {
    func didSelectImage(base64: String) {
        self.imageAvatarBase64 = base64
    }
}
