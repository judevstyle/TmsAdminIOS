//
//  ShipmentCustomerCollectionViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import UIKit

public protocol ShipmentCustomerCollectionViewCellDelegate {
    func didEditAction(items: ShipmentCustomerItems?)
}

class ShipmentCustomerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ShipmentCustomerCollectionViewCell"
    
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var imageThumbnail: UIImageView!
    
    @IBOutlet var badgeView: UIView!
    @IBOutlet var badgeLabel: UILabel!

    @IBOutlet var btnEdit: UIButton!
    
    public var delegate: ShipmentCustomerCollectionViewCellDelegate?
    
    public var items: ShipmentCustomerItems? {
        didSet {
            setupValue()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    func setupUI(){
        bgView.setRounded(rounded: 8)
        bgView.setShadowBoxView()
        imageThumbnail.setRounded(rounded: 8)
        imageThumbnail.contentMode = .scaleAspectFill
        badgeView.roundCorners(corners: .topLeft, radius: 8)
    }
    
    
    func setupValue() {

        if items?.express == true {
            badgeView.isHidden = false
        } else {
            badgeView.isHidden = true
        }
        setImage(url: items?.customer?.avatar)
    }

    private func setImage(url: String?) {
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(url ?? "")") else { return }
        imageThumbnail.kf.setImageDefault(with: urlImage)
    }
    
    @IBAction func editAction(_ sender: Any) {
        delegate?.didEditAction(items: items)
    }
    
}
