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
    
    
    @IBOutlet var viewBoxPrice: UIView!
    
    @IBOutlet var viewBoxCount: UIView!
    @IBOutlet var countText: UILabel!
    
    
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
    
    var itemsShipmentStock: ShipmentStockItems? {
        didSet {
            setupValueShipmentStock()
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
        viewBoxCount.isHidden = true
        viewBoxPrice.isHidden = false
        titleText.text = itemsProductSpecial?.product?.productName ?? ""
        descText.text = itemsProductSpecial?.product?.productDesc ?? ""
        
        let attributeString =  NSMutableAttributedString(string: "\(itemsProductSpecial?.product?.productPrice ?? 0)")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range: NSMakeRange(0, attributeString.length))
        self.priceOld.attributedText = attributeString
        self.priceNew.text = "\(itemsProductSpecial?.itemPrice ?? 0)"
        
        setImage(url: itemsProductSpecial?.product?.productImg)
    }
    
    func setupValueProduct() {
        viewBoxCount.isHidden = true
        viewBoxPrice.isHidden = false
        titleText.text = itemsProduct?.productName ?? ""
        descText.text = itemsProduct?.productDesc ?? ""
        self.priceOld.isHidden = true
        self.priceNew.text = "\(itemsProduct?.productPrice ?? 0)"
        setImage(url: itemsProduct?.productImg)
    }
    
    
    func setupValueShipmentStock() {
        viewBoxCount.isHidden = false
        viewBoxPrice.isHidden = true
        
        titleText.text = itemsShipmentStock?.product?.productName ?? ""
        descText.text = itemsShipmentStock?.product?.productDesc ?? ""
        self.countText.text = "\(itemsShipmentStock?.qty ?? 0)"
        setImage(url: itemsShipmentStock?.product?.productImg)
    }
    
    private func setImage(url: String?) {
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(url ?? "")") else { return }
        imageThumbnail.kf.setImageDefault(with: urlImage)
    }
}
