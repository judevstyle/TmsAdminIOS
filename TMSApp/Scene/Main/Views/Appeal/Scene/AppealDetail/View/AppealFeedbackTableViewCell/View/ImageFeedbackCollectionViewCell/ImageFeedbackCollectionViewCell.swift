//
//  ImageFeedbackCollectionViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/13/21.
//

import UIKit

class ImageFeedbackCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ImageFeedbackCollectionViewCell"
    
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var iconImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setupUI() {

    }
}
