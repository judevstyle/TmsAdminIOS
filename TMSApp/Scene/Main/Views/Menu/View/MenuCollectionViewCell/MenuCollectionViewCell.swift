//
//  MenuCollectionViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/17/21.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MenuCollectionViewCell"

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var menuTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        menuView.setRounded(rounded: 12)
        menuView.layer.borderWidth = 1
        menuView.layer.borderColor = UIColor.Primary.cgColor
    }

}
