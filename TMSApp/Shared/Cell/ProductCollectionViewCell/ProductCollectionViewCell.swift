//
//  ProductCollectionViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var bgView: UIView!
    
    static let identifier = "ProductCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    func setupUI(){
        bgView.setRounded(rounded: 8)
        bgView.setShadowBoxView()
    }
    
}
