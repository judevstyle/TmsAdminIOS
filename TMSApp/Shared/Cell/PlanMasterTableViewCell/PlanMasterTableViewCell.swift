//
//  PlanMasterTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class PlanMasterTableViewCell: UITableViewCell {

    static let identifier = "PlanMasterTableViewCell"

    @IBOutlet weak var bgView: UIView!
    @IBOutlet var badgeView: IconBadgeView!
    
    @IBOutlet var titleText: UILabel!
    @IBOutlet var taskCount: UILabel!
    
    @IBOutlet var imageEmployee: UIImageView!
    @IBOutlet var nameEmployee: UILabel!
    
    var items: PlanMasterItems? {
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
    }
    
    
    func setupUI(){
        bgView.setRounded(rounded: 8)
        bgView.setShadowBoxView()
        
        imageEmployee.setRounded(rounded: imageEmployee.frame.height/2)
        imageEmployee.contentMode = .scaleAspectFill
        badgeView.setTitle(title: "วันธรรมดา")
    }
    
    private func setupValue() {
        
        titleText.text = items?.planName ?? ""
        taskCount.text = "จำนวนร้านที่ต้องส่ง \(items?.totalCustomerToSent ?? 0)"
        nameEmployee.text = items?.empoyeeName ?? ""
        
        if items?.planType == "N" {
            badgeView.setTitle(title: "วันธรรมดา")
        } else if items?.planType == "S" {
            badgeView.setTitle(title: "วันพิเศษ")
        }
        
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(items?.empoyeeImg ?? "")") else { return }
        imageEmployee.kf.setImageDefault(with: urlImage)
    }
}
