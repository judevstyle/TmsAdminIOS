//
//  DayListCollectionViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import UIKit

class DayListCollectionViewCell: UICollectionViewCell {

    static let identifier = "DayListCollectionViewCell"
    
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var titleText: UILabel!
    public var index: Int?
    
    public var isSelectedItem: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        bgView.setRounded(rounded: 8)
        bgView.layer.borderColor = UIColor.Primary.cgColor
        bgView.layer.borderWidth = 0.5
    }
    
    func setState() {
        self.isSelectedItem = !self.isSelectedItem
        if self.isSelectedItem {
            bgView.backgroundColor = UIColor.Primary
            titleText.textColor = .white
        } else {
            bgView.backgroundColor = UIColor.white
            titleText.textColor = UIColor.Primary
        }
    }
}
