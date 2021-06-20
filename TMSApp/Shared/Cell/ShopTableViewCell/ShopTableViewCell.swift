//
//  ShopTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import UIKit

class ShopTableViewCell: UITableViewCell {

    static let identifier = "ShopTableViewCell"
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet var imageShop: UIImageView!
    @IBOutlet var titleText: UILabel!
    
    @IBOutlet var bgBadge: UIView!
    @IBOutlet var titleBadge: UILabel!
    
    @IBOutlet var addresText: UILabel!
    
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
        
        bgBadge.setRounded(rounded: 3)
        bgBadge.layer.borderWidth = 0.5
        bgBadge.layer.borderColor = UIColor.Primary.cgColor
    }
    
}
