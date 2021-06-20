//
//  EmployeeTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/13/21.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    static let identifier = "EmployeeTableViewCell"
    
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
        bgView.setShadowBoxView()
    }
    
}
