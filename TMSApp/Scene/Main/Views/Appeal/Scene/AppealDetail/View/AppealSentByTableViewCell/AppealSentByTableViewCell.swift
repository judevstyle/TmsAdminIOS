//
//  AppealSentByTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/10/21.
//

import UIKit

class AppealSentByTableViewCell: UITableViewCell {
    
    static let identifier = "AppealSentByTableViewCell"
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
    
    func setupUI(){
        appealView.setRounded(rounded: 8)
        appealView.setShadowBoxView()
    }
    
}
