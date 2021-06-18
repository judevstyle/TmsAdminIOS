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
        bgView.layer.shadowColor = UIColor.darkGray.cgColor
        bgView.layer.shadowOpacity = 0.5
        bgView.layer.shadowOffset = .zero
        bgView.layer.shadowRadius = 3
        
    }
    
}