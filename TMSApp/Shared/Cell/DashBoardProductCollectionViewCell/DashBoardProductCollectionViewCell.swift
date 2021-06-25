//
//  DashBoardProductCollectionViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 25/6/2564 BE.
//

import UIKit
import Kingfisher

class DashBoardProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DashBoardProductCollectionViewCell"
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageBgView: UIImageView!
    @IBOutlet weak var bgLabelImage: UIView!
    @IBOutlet weak var labelImage: UILabel!
    @IBOutlet weak var titleText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    var product: TotalOrderProduct? {
        didSet {
            setupUI()
            setValue()
        }
    }
    
    func setupUI() {
        bgView.backgroundColor = .clear
        imageBgView.layer.cornerRadius = layer.bounds.size.width/2
        bgLabelImage.layer.cornerRadius = layer.bounds.size.width/2
        bgLabelImage.backgroundColor = .blackAlpha(alpha: 0.3)
    }
    
    func setValue() {
        titleText.text = product?.product?.productName ?? ""
        labelImage.text = "\(product?.qty ?? 0)"
        let pathUrl = "\(DomainNameConfig.TMSImagePath.urlString)\(product?.productImg ?? "")"
        guard let urlImage = URL(string: pathUrl) else { return }
        imageBgView.kf.setImageDefault(with: urlImage)
    }
    
}
