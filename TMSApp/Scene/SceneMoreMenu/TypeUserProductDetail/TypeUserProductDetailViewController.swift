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
    
    // ViewModel
    lazy var viewModel: TypeUserProductDetailProtocol = {
        let vm = TypeUserProductDetailViewModel(typeUserProductDetailViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupValue()
    }
    
    func configure(_ interface: TypeUserProductDetailProtocol) {
        self.viewModel = interface
    }
    
    @IBAction func handleSave(_ sender: Any) {
        guard let newPrice = newPriceInput.text, newPrice != "" else { return }
        viewModel.input.didConfirmmNewProduct(newPrice: newPrice)
        
    }
    @IBAction func handleDelete(_ sender: Any) {
        viewModel.input.didDeleteProduct()
    }
    
}

extension TypeUserProductDetailViewController {
    func setupUI() {
        btnSave.setRounded(rounded: 8)
        newPriceInput.setRounded(rounded: 8)
        newPriceInput.layer.borderWidth = 1
        newPriceInput.layer.borderColor = UIColor.Primary.cgColor
        newPriceInput.setPaddingLeftAndRight(padding: 8)
        newPriceInput.text = ""
    }
    
    func setupValue() {
        guard let itemTypeUser = viewModel.output.getItemTypeUser() else { return }
        switch viewModel.output.getTypeAction() {
        case .create:
            guard let itemProduct = viewModel.output.getItemProduct() else { return }
            titleText.text = itemProduct.productName ?? ""
            descText.text = itemProduct.productDesc ?? ""
            discountText.isHidden = true
            btnDelete.isHidden = true
            priceText.text = "\(itemProduct.productPrice ?? 0)"
            guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(itemProduct.productImg ?? "")") else { return }
            imageView.kf.setImageDefault(with: urlImage)
        case .update:
            guard let ItemProductSpecial = viewModel.output.getItemProductSpecial() else { return }
            titleText.text = ItemProductSpecial.product?.productName ?? ""
            descText.text = ItemProductSpecial.product?.productDesc ?? ""
            
            let attributeString =  NSMutableAttributedString(string: "\(ItemProductSpecial.product?.productPrice ?? 0)")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range: NSMakeRange(0, attributeString.length))
            self.discountText.attributedText = attributeString
            
            newPriceInput.text = "\(ItemProductSpecial.itemPrice ?? 0)"
            priceText.text = "\(ItemProductSpecial.itemPrice ?? 0)"
            
            guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(ItemProductSpecial.product?.productImg ?? "")") else { return }
            imageView.kf.setImageDefault(with: urlImage)
        }
    }
}

// MARK: - Binding
extension TypeUserProductDetailViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetProductSuccess = didGetProductSuccess()
    }
    
    func didGetProductSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
        }
    }
}
