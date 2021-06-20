//
//  InputRadioGroupView.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import UIKit
import RadioGroup

protocol InputRadioGroupViewDelegate {
    func didSelectRadio(value: String, index: Int)
}

class InputRadioGroupView: UIView {

    let nibName = "InputRadioGroupView"
    var contentView:UIView?
    
    public var delegate: InputRadioGroupViewDelegate?
    
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet var radioGroup: RadioGroup!
    
    private var listRadioTitle: [String] = []
    
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
    }
    
    func setupRadio(listRadio: [String]) {
        self.listRadioTitle = listRadio
        radioGroup.titles = self.listRadioTitle
        
        radioGroup.addTarget(self, action: #selector(didSelectOption(radioGroup:)), for: .valueChanged)
        radioGroup.selectedIndex = 0
        radioGroup.spacing = 20
        radioGroup.itemSpacing = 8
        radioGroup.titleAlignment = .left
        
        radioGroup.tintColor = .gray       // surrounding ring
        radioGroup.selectedColor = .Primary     // inner circle (default is same color as ring)
        radioGroup.selectedTintColor = .Primary  // selected radio button's surrounding ring (default is tintColor)
        radioGroup.titleColor = .black
        radioGroup.titleFont = UIFont.PrimaryText(size: 14)
    }
    
    @objc func didSelectOption(radioGroup: RadioGroup) {
        self.delegate?.didSelectRadio(value: radioGroup.titles[radioGroup.selectedIndex] ?? "", index: radioGroup.selectedIndex)
    }
}
