//
//  AssetTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import UIKit

class AssetTableViewCell: UITableViewCell {

    static let identifier = "AssetTableViewCell"

    @IBOutlet weak var bgView: UIView!
    @IBOutlet var iconImage: UIImageView!
    
    @IBOutlet weak var titleText: UILabel!
    
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var countItemText: UILabel!
    
    @IBOutlet weak var unitNameText: UILabel!
    var items: AssetsItems? {
        didSet {
            setupValue()
        }
    }
    
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
        iconImage.setRounded(rounded: 8)
        iconImage.contentMode = .scaleAspectFill
    }
    
    func setupValue() {
        
        titleText.text = "\(items?.astId ?? 0) \(items?.assetName ?? "")"
        descText.text = items?.assetDesc ?? ""
        countItemText.text = "\(items?.stockTotal ?? 0)"
        unitNameText.text = items?.assetUnit ?? ""
        
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(items?.assetImg ?? "")") else { return }
        iconImage.kf.setImageDefault(with: urlImage)
        
    }
    
}

