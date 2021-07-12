//
//  TruckTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class TruckTableViewCell: UITableViewCell {

    static let identifier = "TruckTableViewCell"

    @IBOutlet weak var bgView: UIView!
    @IBOutlet var iconImage: UIImageView!
    
    @IBOutlet var titleText: UILabel!
    @IBOutlet var descText: UILabel!
    @IBOutlet var noCar: UILabel!
    
    var items: TruckItems? {
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
        
        iconImage.contentMode = .scaleAspectFill
    }
    
    func setupValue(){
        titleText.text = items?.truck_id ?? ""
        descText.text = items?.truck_title ?? ""
        noCar.text = items?.registration_number ?? ""
        
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(items?.truck_img ?? "")") else { return }
        iconImage.kf.setImageDefault(with: urlImage)
    }
    
}
