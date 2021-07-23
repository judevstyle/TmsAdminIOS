//
//  ProductDetailQtyViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/18/21.
//

import UIKit

class ProductDetailQtyViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var titleText: UILabel!
    @IBOutlet var descText: UILabel!
    @IBOutlet var discountText: UILabel!
    @IBOutlet var priceText: UILabel!
    
    @IBOutlet var qtyInput: UITextField!
    
    @IBOutlet var btnAddQty: UIButton!
    @IBOutlet var btnRemoveQty: UIButton!
    
    @IBOutlet var btnSave: UIButton!
    
    // ViewModel
    lazy var viewModel: ProductDetailQtyProtocol = {
        let vm = ProductDetailQtyViewModel(productDetailQtyViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupValue()
    }
    
    func configure(_ interface: ProductDetailQtyProtocol) {
        self.viewModel = interface
    }
    
    @IBAction func handleRemoveQty(_ sender: Any) {
        guard let itemProduct = viewModel.output.getItemProduct() else { return }
        var myQty = ((qtyInput.text as! NSString).integerValue)
        
        if myQty > 0 {
            myQty = myQty - 1
            qtyInput.text = "\(myQty)"
        }
        
    }
    
    @IBAction func handleAddQty(_ sender: Any) {
        guard let itemProduct = viewModel.output.getItemProduct() else { return }
        
        if let isRemove = viewModel.output.getTypeAction(),
           isRemove == .remove {
            let maxQty = viewModel.output.getMaxQty() ?? 0
            var myQty = ((qtyInput.text as! NSString).integerValue)
            if myQty < maxQty {
                myQty = myQty + 1
                qtyInput.text = "\(myQty)"
            }
        } else {
            var myQty = ((qtyInput.text as! NSString).integerValue) + 1
            qtyInput.text = "\(myQty)"
        }
    }
    
    @IBAction func handleSaveQty(_ sender: Any) {
        var newQty = ((qtyInput.text as! NSString).integerValue) ?? 0
        viewModel.input.didConfirmQtyProduct(qty: newQty)
    }
}

extension ProductDetailQtyViewController {
    func setupUI() {
        btnSave.setRounded(rounded: 8)
        btnAddQty.setRounded(rounded: btnAddQty.frame.width/2)
        btnRemoveQty.setRounded(rounded: btnRemoveQty.frame.width/2)
    }
    
    func setupValue() {
        guard let itemProduct = viewModel.output.getItemProduct() else { return }
        titleText.text = itemProduct.productName ?? ""
        descText.text = itemProduct.productDesc ?? ""
        discountText.isHidden = true
        priceText.text = "\(itemProduct.productPrice ?? 0)"
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(itemProduct.productImg ?? "")") else { return }
        imageView.kf.setImageDefault(with: urlImage)
    }
}

// MARK: - Binding
extension ProductDetailQtyViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetProductSuccess = didGetProductSuccess()
    }
    
    func didGetProductSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
        }
    }
}
