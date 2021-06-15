//
//  InputTextFieldDatePicker.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class InputTextFieldDatePicker: UIView {
    
    let nibName = "InputTextFieldDatePicker"
    var contentView:UIView?
    
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var inputText: UITextField!
    
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
        inputText.setRounded(rounded: 5)
        inputText.setPaddingLeftAndRight(padding: 8)
    }
}
