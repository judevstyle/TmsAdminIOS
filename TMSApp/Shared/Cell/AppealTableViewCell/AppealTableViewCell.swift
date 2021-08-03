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
    
    
    var items: FeedbackItems? {
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
        if selected {
        }
    }
    
    func setupUI(){
        appealView.setRounded(rounded: 8)
        appealView.layer.shadowColor = UIColor.darkGray.cgColor
        appealView.layer.shadowOpacity = 0.3
        appealView.layer.shadowOffset = .zero
        appealView.layer.shadowRadius = 2
        
        appealImage.setRounded(rounded: 8)
        appealImage.contentMode = .scaleAspectFill
        
        appealId.font = UIFont.PrimaryText(size: 14)
        appealName.font = UIFont.PrimaryText(size: 14)
        
        //BadgeVIP
        badgeVipView.setRounded(rounded: 3)
        badgeVipView.layer.borderWidth = 0.3
        badgeVipView.layer.borderColor = UIColor.Primary.cgColor
        badgeVipName.text = "VIP customer"
        badgeVipName.font = UIFont.PrimaryText(size: 10)
    }
    
    func setupValue() {
        appealId.text = items?.order?.orderNo ?? "-"
        appealName.text = items?.order?.customer?.displayName ?? "-"
//        badgeVipName.text = items?.order?.customer. ?? "-"
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(items?.order?.customer?.avatar ?? "")") else { return }
        appealImage.kf.setImageDefault(with: urlImage)
        
        if let rate = Double("\(items?.rate ?? "")") {
            if (Int(rate * 10) % 10) == 5 {
                let newRate = (Int(rate * 10) - (Int(rate * 10) % 10))/10
                favoriteIcons.enumerated().forEach({ (index, item) in
                    if index < newRate {
                        item.tintColor = .Primary
                    } else {
                        if index == newRate {
                            item.image = UIImage(systemName: "star.fill.left")?.withRenderingMode(.alwaysTemplate)
                            item.tintColor = .Primary
                        } else {
                            item.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
                            item.tintColor = .lightGray
                        }
                    }
                })
            } else {
                let newRate = Int(rate * 10)/10
                favoriteIcons.enumerated().forEach({ (index, item) in
                    if index < newRate {
                        item.tintColor = .Primary
                    } else {
                        item.tintColor = .lightGray
                    }
                })
            }
//            if (Int(rate * 10) % 10) == 5 {
//                let newRate = (Int(rate * 10) - (Int(rate * 10) % 10))/10
//                for index in 0...newRate {
//                    favoriteIcons[index].tintColor = .Primary
//                }
//            } else {
//                let newRate = Int(rate * 10)/10
//                for index in 0...newRate {
//                    favoriteIcons[index].tintColor = .Primary
//                }
//            }
        }
    }
}
