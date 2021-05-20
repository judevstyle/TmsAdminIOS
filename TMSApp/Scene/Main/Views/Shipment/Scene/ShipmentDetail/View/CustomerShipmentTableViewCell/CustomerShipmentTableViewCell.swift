//
//  CustomerShipmentTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/20/21.
//

import UIKit

class CustomerShipmentTableViewCell: UITableViewCell {

    static let identifier = "CustomerShipmentTableViewCell"

    @IBOutlet weak var customerView: UIView!
    @IBOutlet weak var customerImage: UIImageView!
    @IBOutlet weak var customerName: UILabel!
    
    @IBOutlet weak var badgeVipView: UIView!
    @IBOutlet weak var badgeVipName: UILabel!
    @IBOutlet weak var customerAddress: UILabel!
    
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
        customerView.setRounded(rounded: 8)
        customerView.layer.shadowColor = UIColor.darkGray.cgColor
        customerView.layer.shadowOpacity = 0.5
        customerView.layer.shadowOffset = .zero
        customerView.layer.shadowRadius = 3
        
        customerImage.setRounded(rounded: customerImage.frame.size.width/2)
        
        customerName.font = UIFont.PrimaryText(size: 12)
        
        //BadgeVIP
        badgeVipView.setRounded(rounded: 3)
        badgeVipView.layer.borderWidth = 0.3
        badgeVipView.layer.borderColor = UIColor.Primary.cgColor
        badgeVipName.text = "VVIP"
        badgeVipName.font = UIFont.PrimaryText(size: 8)
        
        customerAddress.font = UIFont.PrimaryText(size: 10)
        customerAddress.numberOfLines = 2
    }
    
    func setData(item: GetOrderResponse?) {
    }
    
}
