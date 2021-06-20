//
//  ButtonPrimaryView.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import UIKit

protocol ButtonPrimaryViewDelegate {
    func onClickButton()
}

class ButtonPrimaryView: UIView {
    
    let nibName = "ButtonPrimaryView"
    var contentView:UIView?
    
    @IBOutlet var buttonPrimary: UIButton!
    
    public var delegate: ButtonPrimaryViewDelegate?
    
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
        buttonPrimary.setRounded(rounded: 8)
    }
    
    func setTitle(title: String) {
        buttonPrimary.setTitle(title, for: .normal)
    }
    
    @IBAction func handleClickButton(_ sender: Any) {
        self.delegate?.onClickButton()
    }
}
