//
//  DeliveryShipmentTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/18/21.
//

import UIKit

class DeliveryShipmentTableViewCell: UITableViewCell {
    
    static let identifier = "DeliveryShipmentTableViewCell"

    @IBOutlet weak var deliveryView: UIView!
    @IBOutlet weak var deliveryImage: UIImageView!
    @IBOutlet weak var deliveryCode: UILabel!
    @IBOutlet weak var deliveryName: UILabel!
    @IBOutlet weak var deliveryNo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setupUI(){
        deliveryView.setRounded(rounded: 8)
        deliveryView.layer.shadowColor = UIColor.darkGray.cgColor
        deliveryView.layer.shadowOpacity = 0.5
        deliveryView.layer.shadowOffset = .zero
        deliveryView.layer.shadowRadius = 3
        
        deliveryImage.setRounded(rounded: 5)
        
        deliveryCode.font = UIFont.PrimaryText(size: 13)
        deliveryName.font = UIFont.PrimaryText(size: 11)
        deliveryNo.font = UIFont.PrimaryText(size: 11)
    }
    
    func setData(item: GetShipmentResponse?) {
    }
    
}
