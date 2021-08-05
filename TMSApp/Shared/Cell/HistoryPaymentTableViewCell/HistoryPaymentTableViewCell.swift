//
//  HistoryPaymentTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/5/21.
//

import UIKit

class HistoryPaymentTableViewCell: UITableViewCell {
    
    static let identifier = "HistoryPaymentTableViewCell"

    @IBOutlet var bgView: UIView!
    @IBOutlet var priceTotal: UILabel!
    
    var item: CreditPaymentItems? {
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
        bgView.setRounded(rounded: 8)
        bgView.layer.borderWidth = 1.0
        bgView.layer.borderColor = UIColor.Primary.cgColor
    }
    
    func setupValue() {
        priceTotal.text = "\(item?.balance ?? 0)"
    }
    
}
