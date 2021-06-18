//
//  UIView+Extension.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 3/27/21.
//

import UIKit

extension UIView {
    
    func setRounded(rounded: CGFloat) {
        self.layer.cornerRadius = rounded
    }
    
    func setShadowBoxView()  {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
