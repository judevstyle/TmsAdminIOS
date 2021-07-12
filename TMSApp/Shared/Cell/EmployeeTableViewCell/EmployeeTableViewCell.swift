//
//  EmployeeTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/13/21.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    static let identifier = "EmployeeTableViewCell"
    
    @IBOutlet var imageThumbnail: UIImageView!
    @IBOutlet var titleText: UILabel!
    @IBOutlet var descText: UILabel!
    @IBOutlet var positionText: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    var items: EmployeeItems? {
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
        
        imageThumbnail.contentMode = .scaleAspectFill
        imageThumbnail.setRounded(rounded: imageThumbnail.frame.width/2)
    }
    
    func setupValue(){
        titleText.text = "รหัสพนักงาน : \(items?.empCode ?? "")"
        descText.text = items?.empDisplayName ?? ""
        positionText.text = "ตำแหน่ง : \(items?.jobPosition?.jobPositionName ?? "")"
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(items?.empAvatar ?? "")") else { return }
        imageThumbnail.kf.setImageDefault(with: urlImage)
    }
    
}
