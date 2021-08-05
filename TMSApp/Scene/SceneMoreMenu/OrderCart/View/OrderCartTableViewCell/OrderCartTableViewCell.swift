//
//  OrderCartTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/30/21.
//

import UIKit

class OrderCartTableViewCell: UITableViewCell {
    
    static let identifier = "OrderCartTableViewCell"
    @IBOutlet weak var orderCartView: UIView!
    
    @IBOutlet weak var imageThubnail: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descText: UILabel!
    
    @IBOutlet weak var badgeTypeView: UIView!
    @IBOutlet weak var badgeTypeName: UILabel!
    
    @IBOutlet weak var discountText: UILabel!
    @IBOutlet weak var priceText: UILabel!
    
    @IBOutlet weak var qytText: UILabel!
    @IBOutlet weak var sumPrice: UILabel!
    
    var items: OrderCartD? {
        didSet {
            setupValue()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        
        orderCartView.setRounded(rounded: 8)
        imageThubnail.setRounded(rounded: 8)
        
        titleText.font = UIFont.PrimaryText(size: 12)
        descText.font = UIFont.PrimaryText(size: 10)
        
        priceText.font = UIFont.PrimaryText(size: 14)
        
        //BadgeVIP
        badgeTypeView.setRounded(rounded: 3)
        badgeTypeView.layer.borderWidth = 0.3
        badgeTypeView.layer.borderColor = UIColor.Primary.cgColor
        badgeTypeName.text = "-"
        badgeTypeName.font = UIFont.PrimaryText(size: 10)
        
        let attributeString =  NSMutableAttributedString(string: "0")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        self.discountText.attributedText = attributeString;
    }
    
    func setupValue() {
        
        titleText.text = "\(items?.product?.productCode ?? "") \(items?.product?.productName ?? "")"
        descText.text = items?.product?.productDesc ?? ""
        badgeTypeName.text = items?.product?.productType?.productTypeName ?? ""
        

        let attributeString =  NSMutableAttributedString(string: "\(items?.product?.productPrice ?? 0)")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        self.discountText.attributedText = attributeString;
        
        priceText.text = "\(items?.price ?? 0)"
        
        qytText.text = "x\(items?.qty ?? 0)"
        sumPrice.text = "รวม ฿\((items?.price ?? 0) * (items?.qty ?? 0))"
        
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(items?.product?.productImg ?? "")") else { return }
        imageThubnail.kf.setImageDefault(with: urlImage)
    }
}
