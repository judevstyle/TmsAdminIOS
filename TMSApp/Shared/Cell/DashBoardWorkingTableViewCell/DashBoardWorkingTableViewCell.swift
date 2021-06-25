//
//  DashBoardWorkingTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 25/6/2564 BE.
//

import UIKit

class DashBoardWorkingTableViewCell: UITableViewCell {
    
    static let identifier = "DashBoardWorkingTableViewCell"
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageThumbnail: UIImageView!
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var carText: UILabel!
    @IBOutlet weak var statusWorking: UILabel!
    
    
    var items: ShipmentItems? {
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
    
    func setupUI() {
        bgView.setRounded(rounded: 8)
        bgView.setShadowBoxView()
        imageThumbnail.setRounded(rounded: imageThumbnail.frame.width/2)
        imageThumbnail.contentMode = .scaleAspectFill
    }
    
    func setupValue(){
        titleText.text = items?.employeeName ?? ""
        descText.text = items?.planName ?? ""
        descText.numberOfLines = 0
        carText.text = items?.truckRegistrationNumber ?? ""
        
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(items?.employeeImg ?? "")") else { return }
        imageThumbnail.kf.setImageDefault(with: urlImage)
    }
}
