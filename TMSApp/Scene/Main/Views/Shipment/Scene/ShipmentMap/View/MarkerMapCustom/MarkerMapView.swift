//
//  MarkerMapView.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/21/21.
//

import UIKit

class MarkerMapView: UIView {

    @IBOutlet weak var InnerView: UIView!
    @IBOutlet weak var bgTitle: UIView!
    @IBOutlet weak var Title: UILabel!
    
    @IBOutlet weak var ImageBg: UIImageView!
    @IBOutlet weak var imageAvatar: UIImageView!
    
    static func instantiate(message: String) -> MarkerMapView {
        let view: MarkerMapView = initFromNib()
        view.ImageBg.image?.withRenderingMode(.alwaysTemplate)
        let pin = UIImage(named: "map-customer")!.withRenderingMode(.alwaysTemplate)
        view.ImageBg.image = pin
        view.ImageBg.tintColor = UIColor.Primary
        view.imageAvatar.setRounded(rounded: view.imageAvatar.frame.width/2)
        view.imageAvatar.image = UIImage(named: "nontawat")?.withRenderingMode(.alwaysOriginal)
        view.bgTitle.setRounded(rounded: 3)
        view.Title.text = message
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.InnerView.addGestureRecognizer(tap)
        view.InnerView.isUserInteractionEnabled = true
        return view
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("TEST")
    }
    
}


extension UIView {
    class func initFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
}
