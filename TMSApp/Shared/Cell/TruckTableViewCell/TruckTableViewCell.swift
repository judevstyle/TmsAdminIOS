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
