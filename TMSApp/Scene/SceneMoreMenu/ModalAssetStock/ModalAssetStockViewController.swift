//
//  ModalAssetStockViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/20/21.
//

import UIKit

class ModalAssetStockViewController: UIViewController {
    
    @IBOutlet var modalView: UIView!
    
    @IBOutlet var inputUnit: UITextField!
    @IBOutlet var inputDesc: InputTextArea!
    @IBOutlet var btnConfirm: ButtonPrimaryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self.view) else { return }
        if !self.modalView.frame.contains(location) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK:- SETUP UI
extension ModalAssetStockViewController {
    func setupUI() {
        self.modalView.setRounded(rounded: 8)
        self.modalView.setShadowBoxView()
        
        
        inputUnit.setRounded(rounded: 5)
        inputUnit.layer.borderWidth = 1
        inputUnit.layer.borderColor = UIColor.Primary.cgColor
        inputUnit.setPaddingLeftAndRight(padding: 8)
        
        
        inputDesc.titleLabel.text = "หมายเหตุ"
        
        btnConfirm.setTitle(title: "ยืนยัน")
        btnConfirm.delegate = self
    }
}

extension ModalAssetStockViewController: ButtonPrimaryViewDelegate {
    func onClickButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
