//
//  CollectibleUserUseTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/20/21.
//

import UIKit

class CollectibleUserUseTableViewCell: UITableViewCell {
    
    static let identifier = "CollectibleUserUseTableViewCell"

    @IBOutlet weak var bgView: UIView!
    @IBOutlet var badgeView: IconBadgeView!
    
    @IBOutlet var titleText: UILabel!
    
    @IBOutlet var imageIcon: UIImageView!
    
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
        
        imageIcon.setRounded(rounded: imageIcon.frame.height/2)
        
        badgeView.setTitle(title: "VVIP")
        
    }
    
}
