//
//  CollectibleTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/20/21.
//

import UIKit

class CollectibleTableViewCell: UITableViewCell {

    static let identifier = "CollectibleTableViewCell"

    @IBOutlet weak var bgView: UIView!
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var countStore: UILabel!
    @IBOutlet var pointText: UILabel!
    @IBOutlet var titleText: UILabel!
    
    var items: CollectibleItems? {
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
        titleText.text = items?.clbTitle ?? ""
        countStore.text = "\(items?.qty ?? 0)"
        pointText.text = "\(items?.rewardPoint ?? 0)"
        
        titleText.sizeToFit()
        countStore.sizeToFit()
        pointText.sizeToFit()
        
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(items?.clbImg ?? "")") else { return }
        iconImage.kf.setImageDefault(with: urlImage)
    }
    
}

