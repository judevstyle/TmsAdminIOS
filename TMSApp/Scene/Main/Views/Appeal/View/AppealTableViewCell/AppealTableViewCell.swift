//
//  AppealTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/18/21.
//

import UIKit

class AppealTableViewCell: UITableViewCell {
    
    static let identifier = "AppealTableViewCell"

    @IBOutlet weak var appealView: UIView!
    @IBOutlet weak var appealImage: UIImageView!
    @IBOutlet weak var appealId: UILabel!
    @IBOutlet weak var appealName: UILabel!
    @IBOutlet weak var badgeVipView: UIView!
    @IBOutlet weak var badgeVipName: UILabel!
    @IBOutlet var favoriteIcons: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            print("Nontawat \(favoriteIcons.count)")
            for item in favoriteIcons {
                item.tintColor = .Primary
            }
        }
    }
    
    func setupUI(){
        appealView.setRounded(rounded: 8)
        appealView.layer.shadowColor = UIColor.darkGray.cgColor
        appealView.layer.shadowOpacity = 0.3
        appealView.layer.shadowOffset = .zero
        appealView.layer.shadowRadius = 2
        
        appealImage.setRounded(rounded: 8)
        
        appealId.font = UIFont.PrimaryText(size: 14)
        appealName.font = UIFont.PrimaryText(size: 14)
        
        //BadgeVIP
        badgeVipView.setRounded(rounded: 3)
        badgeVipView.layer.borderWidth = 0.3
        badgeVipView.layer.borderColor = UIColor.Primary.cgColor
        badgeVipName.text = "VIP customer"
        badgeVipName.font = UIFont.PrimaryText(size: 10)
    }
    
    func setData(item: GetOrderResponse?) {
        
    }
}
