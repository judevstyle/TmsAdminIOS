//
//  OrderCartHeaderTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/30/21.
//

import UIKit

public protocol OrderCartHeaderTableViewCellDelegate {
}

class OrderCartHeaderTableViewCell : UITableViewHeaderFooterView {
    
    private var leftLabel = UILabel()
    
    static let identifier = "OrderCartHeaderTableViewCell"
    
    public var delegate: OrderCartHeaderTableViewCellDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.leftLabel)
        self.leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(16)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        leftLabel.textAlignment = .left
        leftLabel.font = UIFont.PrimaryMedium(size: 13)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(title:String) {
        self.leftLabel.text = title
        self.contentView.backgroundColor = .white
    }
}
