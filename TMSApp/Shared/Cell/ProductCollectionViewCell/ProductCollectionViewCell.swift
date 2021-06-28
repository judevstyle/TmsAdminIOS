//
//  ProductCollectionViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var imageThumbnail: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descText: UILabel!
    
    @IBOutlet weak var priceOld: UILabel!
    @IBOutlet weak var priceNew: UILabel!
    
    static let identifier = "ProductCollectionViewCell"
    
    var itemsProductSpecial: ProductSpecialForTypeUserItems? {
        didSet {
            setupValueProductSpecial()
        }
    }
    
    var itemsProduct: Product? {
        didSet {
            setupValueProduct()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    func setupUI(){
        bgView.setRounded(rounded: 8)
        bgView.setShadowBoxView()
    }
    
    func setupValueProductSpecial() {
        titleText.text = itemsProductSpecial?.product?.productName ?? ""
        descText.text = itemsProductSpecial?.product?.productDesc ?? ""
        
        let attributeString =  NSMutableAttributedString(string: "\(itemsProductSpecial?.product?.productPrice ?? 0)")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range: NSMakeRange(0, attributeString.length))
        self.priceOld.attributedText = attributeString
        
        self.priceNew.text = "\(itemsProductSpecial?.itemPrice ?? 0)"
        
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(itemsProductSpecial?.product?.productImg ?? "")") else { return }
        imageThumbnail.kf.setImageDefault(with: urlImage)
    }
    
    func setupValueProduct() {
        titleText.text = itemsProduct?.productName ?? ""
        descText.text = itemsProduct?.productDesc ?? ""
    
        
        self.priceOld.isHidden = true
        
        self.priceNew.text = "\(itemsProduct?.productPrice ?? 0)"
        
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(itemsProduct?.productImg ?? "")") else { return }
        imageThumbnail.kf.setImageDefault(with: urlImage)
    }
}
