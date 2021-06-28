//
//  TypeUserTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class TypeUserTableViewCell: UITableViewCell {

    static let identifier = "TypeUserTableViewCell"

    @IBOutlet weak var bgIcon: UIView!
    @IBOutlet weak var iconText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    var items: TypeUserData? {
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
    }
    
    func setupUI(){
        bgView.setRounded(rounded: 8)
        bgView.setShadowBoxView()
        bgIcon.setRounded(rounded: bgIcon.frame.width/2)
    }
    
    func setupValue(){
        titleText.text = items?.typeName ?? ""

        guard let typeName = items?.typeName else { return }
        let char = typeName[typeName.index(typeName.startIndex, offsetBy: 0)]
        iconText.text = "\(char)"
    }
}
