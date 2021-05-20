//
//  HeaderShipmentDetailTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/18/21.
//

import UIKit
import SnapKit


public protocol HeaderShipmentDetailTableViewCellDelegate {
    func didTapMapButton()
}

class HeaderShipmentDetailTableViewCell : UITableViewHeaderFooterView {
    
    private var leftLabel = UILabel()
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.init(named: "google_maps"), for: .normal)
        button.setTitleColor(UIColor.Primary, for: .normal)
        button.titleLabel?.font = UIFont.PrimaryMedium(size: 13)
        button.addTarget(self, action: #selector(didTapMap), for: .touchUpInside)
        return button
    }()
    
    static let identifier = "HeaderShipmentDetailTableViewCell"
    
    public var delegate: HeaderShipmentDetailTableViewCellDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.leftLabel)
        self.leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        leftLabel.textAlignment = .center
        leftLabel.font = UIFont.PrimaryMedium(size: 13)
        
        self.contentView.addSubview(self.rightButton)
        self.rightButton.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(26)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(title:String, type: SectionShipment) {
        self.leftLabel.text = title
        if type == .Customer {
            self.rightButton.isHidden = false
        }else {
            self.rightButton.isHidden = true
        }
        self.contentView.backgroundColor = .white
    }
    
    @objc func didTapMap() {
        delegate?.didTapMapButton()
    }
}
