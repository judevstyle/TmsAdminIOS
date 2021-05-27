//
//  CustomerSettingTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/22/21.
//

import UIKit


class CustomerSettingTableViewCell: UITableViewCell {
    
    static let identifier = "CustomerSettingTableViewCell"
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var lineUnderBottom: UIView!
    
    var iconName: String = "" {
        didSet {
            guard let image  = UIImage(systemName: iconName) else { return }
            iconImage.image = image
        }
    }
    
    var title: String = "" {
        didSet {
            titleText.text = title
        }
    }
    
    public func setHidelineUnderBottom(isHidden: Bool = false){
        self.lineUnderBottom.isHidden = isHidden
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
