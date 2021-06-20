//
//  HeaderPrimaryBottomLineTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import UIKit

protocol HeaderPrimaryBottomLineTableViewCellDelegate {
    func didSelectHeader(section: Int)
}

class HeaderPrimaryBottomLineTableViewCell: UITableViewHeaderFooterView {
    
    static let identifier = "HeaderPrimaryBottomLineTableViewCell"
    
    public var delegate: HeaderPrimaryBottomLineTableViewCellDelegate?
    
    private var section: Int = 0
    
    private var bgLabel : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Primary
        return view
    }()
    
    private var stackView : UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()

    private var leftLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        return label
    }()
    
    private var iconImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "gear")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private var lineBottomView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Primary
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI()  {
        
        self.contentView.addSubview(self.bgLabel)
        self.bgLabel.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.leftLabel)
        self.stackView.addArrangedSubview(self.iconImageView)
        self.contentView.addSubview(self.lineBottomView)
        
        self.stackView.anchor(self.bgLabel.topAnchor, left: self.bgLabel.leftAnchor, bottom: self.bgLabel.bottomAnchor, right: self.bgLabel.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        self.bgLabel.anchor(self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.iconImageView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 15, heightConstant: 0)
        
        self.lineBottomView.anchor(nil, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        
        leftLabel.textAlignment = .left
        leftLabel.font = UIFont.PrimaryMedium(size: 13)
    }
    
    func setState(title:String, isEdit: Bool, section: Int)  {
        self.leftLabel.text = title
        self.contentView.backgroundColor = .white
        self.section = section
        
        if isEdit {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            bgLabel.addGestureRecognizer(tap)
            bgLabel.isUserInteractionEnabled = true
            self.iconImageView.isHidden = false
        } else {
            bgLabel.isUserInteractionEnabled = false
            self.iconImageView.isHidden = true
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.delegate?.didSelectHeader(section: self.section)
     }

}
