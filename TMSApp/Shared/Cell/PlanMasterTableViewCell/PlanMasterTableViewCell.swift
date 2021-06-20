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
        
        imageEmployee.setRounded(rounded: imageEmployee.frame.height/2)
        
        badgeView.setTitle(title: "วันธรรมดา")
        
    }
    
}
