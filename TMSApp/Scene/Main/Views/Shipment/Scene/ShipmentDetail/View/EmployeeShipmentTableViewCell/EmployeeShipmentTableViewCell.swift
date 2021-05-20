//
//  EmployeeShipmentTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/20/21.
//

import UIKit

class EmployeeShipmentTableViewCell: UITableViewCell {
    
    static let identifier = "EmployeeShipmentTableViewCell"

    @IBOutlet weak var employeeView: UIView!
    @IBOutlet weak var employeeImage: UIImageView!
    @IBOutlet weak var employeeCode: UILabel!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeePosition: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setupUI(){
        employeeView.setRounded(rounded: 8)
        employeeView.layer.shadowColor = UIColor.darkGray.cgColor
        employeeView.layer.shadowOpacity = 0.5
        employeeView.layer.shadowOffset = .zero
        employeeView.layer.shadowRadius = 3
        
        employeeImage.setRounded(rounded: employeeImage.frame.size.width/2)
        
        employeeCode.font = UIFont.PrimaryText(size: 13)
        employeeName.font = UIFont.PrimaryText(size: 11)
        employeePosition.font = UIFont.PrimaryText(size: 11)
    }
    
    func setData(item: GetShipmentResponse?) {
    }
    
}
