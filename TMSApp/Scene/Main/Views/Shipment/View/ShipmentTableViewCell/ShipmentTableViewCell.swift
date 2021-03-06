//
//  ShipmentTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/15/21.
//

import UIKit

class ShipmentTableViewCell: UITableViewCell {
    
    static let identifier = "ShipmentTableViewCell"

    @IBOutlet weak var shippingView: UIView!
    @IBOutlet weak var shipmentImage: UIImageView!
    @IBOutlet weak var shipmentTitle: UILabel!
    @IBOutlet weak var shipmentType: UILabel!
    @IBOutlet weak var shipmentCarNumber: UILabel!
    @IBOutlet weak var shipmentOrderNo: UILabel!
    
    //Shipping
    @IBOutlet weak var shippingStore: UILabel!
    @IBOutlet weak var shippingStoreValue: UILabel!
    
    @IBOutlet weak var shippingWait: UILabel!
    @IBOutlet weak var shippingWaitValue: UILabel!
    
    @IBOutlet weak var shippingSuccess: UILabel!
    @IBOutlet weak var shippingSuccessValue: UILabel!
    
    @IBOutlet weak var shippingFailed: UILabel!
    @IBOutlet weak var shippingFailedValue: UILabel!
    
    var items: ShipmentItems? {
        didSet {
            setupValue()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupUI(){
        shippingView.setRounded(rounded: 8)
        shippingView.layer.shadowColor = UIColor.darkGray.cgColor
        shippingView.layer.shadowOpacity = 0.3
        shippingView.layer.shadowOffset = .zero
        shippingView.layer.shadowRadius = 2
        
        shipmentImage.setRounded(rounded: shipmentImage.frame.size.width/2)
        
        shipmentTitle.font = UIFont.PrimaryText(size: 13)
        shipmentType.font = UIFont.PrimaryText(size: 11)
        shipmentCarNumber.font = UIFont.PrimaryText(size: 11)
        shipmentOrderNo.font = UIFont.PrimaryText(size: 13)
        
        shippingStore.font = UIFont.PrimaryText(size: 10)
        shippingWait.font = UIFont.PrimaryText(size: 10)
        shippingSuccess.font = UIFont.PrimaryText(size: 10)
        shippingFailed.font = UIFont.PrimaryText(size: 10)
        
        
        shippingStoreValue.font = UIFont.PrimaryText(size: 14)
        shippingWaitValue.font = UIFont.PrimaryText(size: 14)
        shippingSuccessValue.font = UIFont.PrimaryText(size: 14)
        shippingFailedValue.font = UIFont.PrimaryText(size: 14)
        
        shipmentImage.contentMode = .scaleAspectFill
        shipmentType.numberOfLines = 0
    }
    
    func setupValue() {
        
        shipmentTitle.text = items?.employeeName ?? ""
        shipmentType.text = "????????????????????????????????? : \(items?.planName ?? "")"
        shipmentCarNumber.text = items?.truckRegistrationNumber ?? ""
        shipmentOrderNo.text = "Shipment Order : \(items?.shipmentNo ?? "")"
        
        shippingStoreValue.text = "\(items?.customerShipmentNumber?.totalCustomer ?? 0)"
        shippingWaitValue.text = "\(items?.customerShipmentNumber?.totalToSend ?? 0)"
        shippingSuccessValue.text = "\(items?.customerShipmentNumber?.totalSended ?? 0)"
        shippingFailedValue.text = "\(items?.customerShipmentNumber?.totalSendNotSuccess ?? 0)"
        
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(items?.employeeImg ?? "")") else { return }
        shipmentImage.kf.setImageDefault(with: urlImage)
    }
    
    
}
