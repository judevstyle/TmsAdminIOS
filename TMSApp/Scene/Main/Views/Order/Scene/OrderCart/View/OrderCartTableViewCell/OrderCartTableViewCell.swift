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
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descText: UILabel!
    
    @IBOutlet weak var badgeTypeView: UIView!
    @IBOutlet weak var badgeTypeName: UILabel!
    
    @IBOutlet weak var discountText: UILabel!
    @IBOutlet weak var priceText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(item: GetOrderResponse?) {
    }
    
    
    func setupUI() {
        
        orderCartView.setRounded(rounded: 8)
//        orderCartView.layer.shadowColor = UIColor.darkGray.cgColor
//        orderCartView.layer.shadowOpacity = 0.5
//        orderCartView.layer.shadowOffset = .zero
//        orderCartView.layer.shadowRadius = 3
        
        titleText.font = UIFont.PrimaryText(size: 12)
        descText.font = UIFont.PrimaryText(size: 10)
        
        priceText.font = UIFont.PrimaryText(size: 14)
        
        //BadgeVIP
        badgeTypeView.setRounded(rounded: 3)
        badgeTypeView.layer.borderWidth = 0.3
        badgeTypeView.layer.borderColor = UIColor.Primary.cgColor
        badgeTypeName.text = "น้ำดื่ม"
        badgeTypeName.font = UIFont.PrimaryText(size: 10)
        
        let attributeString =  NSMutableAttributedString(string: "20")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        self.discountText.attributedText = attributeString;
    }
}
