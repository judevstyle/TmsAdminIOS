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
    @IBOutlet weak var descText: UILabel!
    
    @IBOutlet weak var orderAddress: UILabel!
    
    @IBOutlet weak var orderList: UILabel!
    
    @IBOutlet weak var orderPrice: UILabel!
    
    var items: OrderItems? {
        didSet {
            self.setupValue()
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
    
    func setupValue() {
        
        orderId.text = "รหัสร้านค้า : \(items?.cusId ?? 0)"
        descText.text = "\(items?.customerDisplayName ?? "")"
        orderAddress.text = "\(items?.customerAddress ?? "")"
        orderList.text = "\(items?.totalItem ?? 0) รายการ"
        orderPrice.text = "\(Int(items?.balance ?? 0.0) ?? 0) บาท"
        
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(items?.customerAvatar ?? "")") else { return }
        orderImage.kf.setImageDefault(with: urlImage)
    }
    
}
