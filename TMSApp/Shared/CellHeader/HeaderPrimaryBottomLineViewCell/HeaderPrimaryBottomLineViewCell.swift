//
//  HeaderPrimaryBottomLineViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/3/21.
//

import Foundation
import UIKit

protocol HeaderPrimaryBottomLineViewCellDelegate {
    func didSelectHeader(section: Int)
}

class HeaderPrimaryBottomLineViewCell: UIView {
    
    @IBOutlet var test: UILabel!
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var stackView: UIStackView!
    
    @IBOutlet var bgImage: UIView!
    @IBOutlet var iconImageView: UIImageView!
    
    @IBOutlet var bgLabel: UIView!
    @IBOutlet var leftLabel: UILabel!
    
    private var section: Int = 0
    
    public var delegate: HeaderPrimaryBottomLineViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    func loadNib(){
        Bundle.main.loadNibNamed("HeaderPrimaryBottomLineViewCell", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        setupUI()
    }
    
    func setupUI() {
        iconImageView.image = UIImage(named: "gear")?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
    }
    
    func setState(title:String, isEdit: Bool, section: Int)  {
        self.leftLabel.text = title
        self.section = section
        
        if isEdit {
            self.iconImageView.isHidden = false
            self.bgImage.isHidden = false
        } else {
            self.bgImage.isHidden = true
            self.iconImageView.isHidden = true
        }
    }
    
}
