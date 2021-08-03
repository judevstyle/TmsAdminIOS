//
//  BillNowTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/3/21.
//

import UIKit

class BillNowTableViewCell: UITableViewCell {
    
    static let identifier = "BillNowTableViewCell"
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var orderNo: UILabel!
    @IBOutlet var productCount: UILabel!
    @IBOutlet var paymentPrice: UILabel!
    @IBOutlet var status: UILabel!
    
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
        
        bgView.setRounded(rounded: 5)
        bgView.layer.borderWidth = 1.0
        bgView.layer.borderColor = UIColor.Primary.cgColor

    }
    
    func setupValue(){

    }
}
