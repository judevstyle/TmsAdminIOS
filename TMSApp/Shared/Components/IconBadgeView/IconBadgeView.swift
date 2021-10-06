//
//  IconBadgeView.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import UIKit

class IconBadgeView: UIView {
    
    let nibName = "IconBadgeView"
    var contentView:UIView?

    @IBOutlet var bgBadge: UIView!
    @IBOutlet var labelBadge: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupUI()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setupUI() {
        bgBadge.setRounded(rounded: 3)
        bgBadge.layer.borderWidth = 0.5
        bgBadge.layer.borderColor = UIColor.Primary.cgColor
    }
    
    func setTitle(title: String) {
        labelBadge.text = title
        labelBadge.sizeToFit()
    }
}
