//
//  AppealFeedbackTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/10/21.
//

import UIKit

class AppealFeedbackTableViewCell: UITableViewCell {
    static let identifier = "AppealFeedbackTableViewCell"
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var appealView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setHide() {
        label1.isHidden = true
        label2.isHidden = true
        label3.isHidden = true
    }
    
    func setupUI(){
        appealView.setRounded(rounded: 8)
        appealView.layer.shadowColor = UIColor.darkGray.cgColor
        appealView.layer.shadowOpacity = 0.5
        appealView.layer.shadowOffset = .zero
        appealView.layer.shadowRadius = 3
    }
    
}
