//
//  MainDashBoardHeaderTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/7/21.
//

import Foundation
import UIKit

class MainDashBoardHeaderTableViewCell : UITableViewHeaderFooterView {
    
    private var leftLabel : PaddingLabel = {
        let label = PaddingLabel(withInsets: 0, 0, 8, 8)
        label.backgroundColor = UIColor.Primary
        label.textColor = UIColor.white
        return label
    }()
    
    private var leftView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Primary
        return view
    }()
    
    static let identifier = "MainDashBoardHeaderTableViewCell"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.leftLabel)
        self.contentView.addSubview(self.leftView)
        
        self.leftLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(8)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        self.leftView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(8)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
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
