//
//  OrderTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/16/21.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    static let identifier = "OrderTableViewCell"

    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var orderName: UILabel!
    
    @IBOutlet weak var badgeVipView: UIView!
    @IBOutlet weak var badgeVipName: UILabel!
    
    @IBOutlet weak var orderAddress: UILabel!
    
    @IBOutlet weak var orderList: UILabel!
    @IBOutlet weak var orderSumBalance: UILabel!
    
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
        orderView.setRounded(rounded: 8)
        orderView.layer.shadowColor = UIColor.darkGray.cgColor
        orderView.layer.shadowOpacity = 0.5
        orderView.layer.shadowOffset = .zero
        orderView.layer.shadowRadius = 3
        
        orderImage.setRounded(rounded: 12)
        
        orderId.font = UIFont.PrimaryText(size: 12)
        orderName.font = UIFont.PrimaryText(size: 12)
        
        //BadgeVIP
        badgeVipView.setRounded(rounded: 3)
        badgeVipView.layer.borderWidth = 0.3
        badgeVipView.layer.borderColor = UIColor.Primary.cgColor
        badgeVipName.text = "VIP customer"
        badgeVipName.font = UIFont.PrimaryText(size: 8)
        
        orderAddress.font = UIFont.PrimaryText(size: 10)
        orderAddress.numberOfLines = 2
        orderList.font = UIFont.PrimaryText(size: 10)
        orderSumBalance.font = UIFont.PrimaryText(size: 10)
    }
    
    func setData(item: GetOrderResponse?) {
    }
    
}
