//
//  TypeUserProductDetailViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/17/21.
//

import UIKit

class TypeUserProductDetailViewController: UIViewController {
    
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var titleText: UILabel!
    @IBOutlet var descText: UILabel!
    @IBOutlet var discountText: UILabel!
    @IBOutlet var priceText: UILabel!
    
    @IBOutlet var newPriceInput: UITextField!
    
    @IBOutlet var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    @IBAction func handleSave(_ sender: Any) {
    }
    @IBAction func handleDelete(_ sender: Any) {
    }
    
}

extension TypeUserProductDetailViewController {
    func setupUI() {
        btnSave.setRounded(rounded: 8)
        newPriceInput.setRounded(rounded: 8)
        newPriceInput.layer.borderWidth = 1
        newPriceInput.layer.borderColor = UIColor.Primary.cgColor
        newPriceInput.setPaddingLeftAndRight(padding: 8)
    }
}
