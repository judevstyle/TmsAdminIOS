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
    
    @IBOutlet weak var orderAddress: UILabel!
    
    @IBOutlet weak var orderList: UILabel!
    
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
        orderView.layer.shadowOpacity = 0.3
        orderView.layer.shadowOffset = .zero
        orderView.layer.shadowRadius = 2
        
        orderImage.setRounded(rounded: 12)
        
        orderId.font = UIFont.PrimaryText(size: 14)

        
        orderAddress.font = UIFont.PrimaryText(size: 10)
        orderAddress.numberOfLines = 2
    }
    
    func setData(item: GetOrderResponse?) {
    }
    
}
