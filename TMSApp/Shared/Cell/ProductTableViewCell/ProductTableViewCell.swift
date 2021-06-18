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
    
    @IBOutlet var bgBadge: UIView!
    @IBOutlet var titleBadge: UILabel!
    
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
        
    }
    
}
