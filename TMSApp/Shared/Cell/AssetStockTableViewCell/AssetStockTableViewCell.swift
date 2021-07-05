//
//  AssetStockTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import UIKit

class AssetStockTableViewCell: UITableViewCell {

    static let identifier = "AssetStockTableViewCell"

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet var countText: UILabel!
    @IBOutlet var unitText: UILabel!
    
    @IBOutlet var noteLabel: UILabel!
    
    @IBOutlet var createByText: UILabel!
    
    @IBOutlet var dateText: UILabel!
    
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
//        bgView.setRounded(rounded: 8)
//        bgView.setShadowBoxView()
    }
    
    func setupValueAssetStock(items: AssetStockItems?, itemDetail: AssetsItems?) {
        countText.text = "\(items?.quantity ?? 0)"
        unitText.text = itemDetail?.assetUnit ?? ""
    }
    
    func setupValueAssetPickupStock(items: AssetPickupStockItems?, itemDetail: AssetsItems?) {
        countText.text = "\(items?.quantity ?? 0)"
        unitText.text = itemDetail?.assetUnit ?? ""
    }
}

