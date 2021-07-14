//
//  SequenceShipmentTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class SequenceShipmentTableViewCell: UITableViewCell {

    static let identifier = "SequenceShipmentTableViewCell"

    @IBOutlet weak var bgView: UIView!
    @IBOutlet var thubnailImage: UIImageView!
    
    @IBOutlet var titleText: UILabel!
    @IBOutlet var iconDelivery: UIImageView!
    
    @IBOutlet var bgBadge: UIView!
    @IBOutlet var textBadge: UILabel!
    
    @IBOutlet var addressText: UILabel!
    
    
    var items: ShipmentCustomerItems? {
        didSet {
            setupValue()
        }
    }
    
    var itemsCustomer: CustomerItems? {
        didSet {
            setupValueCustomer()
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
    
    func setupUI(){
        bgView.setRounded(rounded: 8)
        bgView.layer.shadowColor = UIColor.darkGray.cgColor
        bgView.layer.shadowOpacity = 0.3
        bgView.layer.shadowOffset = .zero
        bgView.layer.shadowRadius = 2
        
        bgBadge.setRounded(rounded: 3)
        bgBadge.layer.borderWidth = 1
        bgBadge.layer.borderColor = UIColor.Primary.cgColor
        
        thubnailImage.setRounded(rounded: thubnailImage.frame.width/2)
        thubnailImage.contentMode = .scaleAspectFill
        
    }
    
    func setHideIconDelivery(isHidden: Bool) {
        self.iconDelivery.isHidden = isHidden
    }
    
    func setupValue() {
        titleText.text = items?.customer?.displayName ?? ""
        textBadge.text = items?.customer?.typeUser?.typeName ?? ""
        
        if items?.express == true {
            self.iconDelivery.isHidden = false
        } else {
            self.iconDelivery.isHidden = true
        }
        addressText.text = items?.customer?.address ?? ""
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(items?.customer?.avatar ?? "")") else { return }
        thubnailImage.kf.setImageDefault(with: urlImage)
    }
    
    func setupValueCustomer() {
        titleText.text = itemsCustomer?.displayName ?? ""
        textBadge.text = itemsCustomer?.typeUser?.typeName ?? ""
        
        self.iconDelivery.isHidden = true
        
        addressText.text = itemsCustomer?.address ?? ""
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(itemsCustomer?.avatar ?? "")") else { return }
        thubnailImage.kf.setImageDefault(with: urlImage)
    }
}
