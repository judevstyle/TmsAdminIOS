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
    @IBOutlet weak var bgImageView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonImage: UIButton!
    
    @IBOutlet weak var keyboardViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var displayNameView: InputTextFieldView!
    @IBOutlet weak var fristNameView: InputTextFieldView!
    @IBOutlet weak var lastNameView: InputTextFieldView!
    @IBOutlet weak var tel1View: InputTextFieldView!
    @IBOutlet weak var tel2View: InputTextFieldView!
    @IBOutlet weak var dateView: InputTextFieldDatePicker!
    @IBOutlet weak var addressView: InputTextArea!
    @IBOutlet weak var positionView: InputTextFieldPickerView!

    @IBOutlet weak var imageGrid: CollectionViewImageGrid!
    
    let pickerPositionView = ToolbarPickerView()
    let positionList = ["พนักงานส่งของ", "นักส่งของใหม่"]
    var selectedPosition : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerKeyboardObserver()
        hideKeyboardWhenTappedAround()
    }
    
    deinit {
       removeObserver()
    }
}

extension EditEmployeeViewController {
    func setupUI() {
        bgImageView.setRounded(rounded: 5)
        imageView.setRounded(rounded: 5)
        
        displayNameView.inputText.delegate = self
        fristNameView.inputText.delegate = self
        lastNameView.inputText.delegate = self
        tel1View.inputText.delegate = self
        tel2View.inputText.delegate = self
        dateView.inputText.delegate = self
        
        displayNameView.titleLabel.text = "ชื่อที่แสดง"
        fristNameView.titleLabel.text = "ชื่อ"
        lastNameView.titleLabel.text = "สกุล"
        tel1View.titleLabel.text = "เบอร์โทร 1"
        tel2View.titleLabel.text = "เบอร์โทร 2"
        dateView.titleLabel.text = "วันเกิด"
        addressView.titleLabel.text = "ที่อยู่"
        positionView.titleLabel.text = "ตำแหน่ง"
        imageGrid.titleLabel.text = "เอกสารประจำตัว"
        
        self.dateView.inputText.setInputViewDatePicker(target: self, selector: #selector(tapDoneDatePicker))
        
        setupDelegatesPostionPickerView()
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

