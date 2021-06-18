//
//  SequenceShipmentTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class SequenceShipmentTableViewCell: UITableViewCell {

    static let identifier = "SequenceShipmentTableViewCell"

    @IBOutlet weak var bgView: UIView!
    @IBOutlet var thubnailImage: UIImageView!
    
    @IBOutlet var titleText: UILabel!
    @IBOutlet var iconDelivery: UIImageView!
    
    @IBOutlet var bgBadge: UIView!
    @IBOutlet var textBadge: UILabel!
    
    @IBOutlet var addressText: UILabel!
    
    
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
        bgView.layer.shadowColor = UIColor.darkGray.cgColor
        bgView.layer.shadowOpacity = 0.3
        bgView.layer.shadowOffset = .zero
        bgView.layer.shadowRadius = 2
        
        bgBadge.setRounded(rounded: 8)
        bgBadge.layer.borderWidth = 1
        bgBadge.layer.borderColor = UIColor.Primary.cgColor
        
    }
    
    func setHideIconDelivery(isHidden: Bool) {
        self.iconDelivery.isHidden = isHidden
    }
}
