//
//  ProductTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static let identifier = "ProductTableViewCell"

    @IBOutlet weak var bgView: UIView!
    @IBOutlet var iconImage: UIImageView!
    
    @IBOutlet weak var titletext: UILabel!
    
    @IBOutlet weak var descText: UILabel!
    
    @IBOutlet var bgBadge: UIView!
    @IBOutlet var titleBadge: UILabel!
    
    @IBOutlet weak var priceText: UILabel!
    var items: Product? {
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
    
    
    func setupUI(){
        bgView.setRounded(rounded: 8)
        bgView.setShadowBoxView()
        
        //BadgeVIP
        bgBadge.setRounded(rounded: 3)
        bgBadge.layer.borderWidth = 0.3
        bgBadge.layer.borderColor = UIColor.Primary.cgColor
        titleBadge.text = "น้ำดื่ม"
        titleBadge.font = UIFont.PrimaryText(size: 10)
        
        iconImage.setRounded(rounded: 8)
    }
    
    func setupValue() {
        
        titletext.text = items?.productName ?? ""
        descText.text = items?.productDesc ?? ""
        titleBadge.text = items?.productType?.productTypeName ?? ""
        
        priceText.text = "\(items?.productPrice ?? 0)"
        
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(items?.productImg ?? "")") else { return }
        iconImage.kf.setImageDefault(with: urlImage)
    }
    
}
