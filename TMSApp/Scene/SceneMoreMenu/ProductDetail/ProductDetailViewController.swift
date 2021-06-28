//
//  ProductDetailViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet var imageThumbnail: UIImageView!
    @IBOutlet var btnChooseImage: UIButton!
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var sizeText: UILabel!
    @IBOutlet weak var typeText: UILabel!
    @IBOutlet weak var givePointText: UILabel!
    @IBOutlet weak var priceText: UILabel!
    
    var imagePicker: ImagePicker!
    
    lazy var viewModel: ProductDetailProtocol = {
        let vm = ProductDetailViewModel(productDetailViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        viewModel.input.getProductDetail()
    }
    
    func configure(_ interface: ProductDetailProtocol) {
        self.viewModel = interface
    }
    
    @IBAction func handleChooseImage(_ sender: UIButton) {
//        self.imagePicker.present(from: sender)
    }
}

// MARK: - Binding
extension ProductDetailViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetProductDetailSuccess = didGetProductDetailSuccess()
    }
    
    func didGetProductDetailSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            self?.setupValue()
        }
    }
}


extension ProductDetailViewController {
    func setupUI() {
        self.imagePicker = ImagePicker(presentationController: self, sourceType: [.camera, .photoLibrary], delegate: self)
        
        priceText.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)    }
    
    func setupValue(){
        guard let item = viewModel.output.getProductDetail() else { return }
//        debugPrint(item.toJSON())
        
        
        titleText.text = item.productName ?? "-"
        descText.text = item.productDesc ?? "-"
        sizeText.text = item.productDimension ?? "-"
        givePointText.text = "ซื้อจำนวน \(item.productCountPerPoint ?? 0)  ได้รับ \(item.productPoint ?? 0)"
        
        priceText.text = "\(item.productPrice ?? 0)"

        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(item.productImg ?? "")") else { return }
        imageThumbnail.kf.setImageDefault(with: urlImage)
    }
}


extension ProductDetailViewController : ImagePickerDelegate {
    func didSelectImage(image: UIImage?, imagePicker: ImagePicker, base64: String) {
        self.imageThumbnail.image = image
    }
}
