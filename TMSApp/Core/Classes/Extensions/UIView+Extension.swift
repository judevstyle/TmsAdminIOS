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


extension UIView {
    
    func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        
        _ = anchorPositionReturn(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
        
    }
    
    func anchorPositionReturn(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint]{
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
        
    }
    
    
    func updateConstraint(attribute: NSLayoutConstraint.Attribute, constant: CGFloat) -> Void {
        
        
        if let constraint = (self.constraints.filter{$0.firstAttribute == attribute}.first) {
            
            constraint.constant = constant
            
        }
    }
    
    
    func setConstraintConstant(constant: CGFloat,
                               forAttribute attribute: NSLayoutConstraint.Attribute) -> Bool
    {
        if let constraint = constraintForAttribute(attribute: attribute) {
            constraint.constant = constant
            
            //            UIView.animate(withDuration: 0.2) {
            //
            //            self.layoutIfNeeded()
            //
            //             }
            
            return true
        }
        else {
            superview?.addConstraint(NSLayoutConstraint(
                                        item: self,
                                        attribute: attribute,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1.0, constant: constant))
            return false
        }
    }
    
    func constraintConstantforAttribute(attribute: NSLayoutConstraint.Attribute) -> CGFloat?
    {
        if let constraint = constraintForAttribute(attribute: attribute) {
            return constraint.constant
        }
        else {
            return nil
        }
    }
    
    func constraintForAttribute(attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint?
    {
        return superview?.constraints.filter({
            $0.firstAttribute == attribute
        }).first
    }
    
}
