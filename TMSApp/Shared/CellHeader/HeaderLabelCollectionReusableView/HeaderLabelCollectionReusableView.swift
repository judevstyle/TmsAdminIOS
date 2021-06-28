//
//  HeaderLabelCollectionReusableView.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import UIKit

class HeaderLabelCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderLabelCollectionReusableView"

    private var leftLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.text = "TEstetess"
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        self.addSubview(self.leftLabel)
        
        self.leftLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        leftLabel.textAlignment = .left
        leftLabel.font = UIFont.PrimaryMedium(size: 13)
        
        leftLabel.text = "Test"
    }
    
}
