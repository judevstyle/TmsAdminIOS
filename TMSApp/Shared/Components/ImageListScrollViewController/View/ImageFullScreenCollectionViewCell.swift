//
//  ImageFullScreenCollectionViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/6/21.
//

import UIKit

class ImageFullScreenCollectionViewCell: UICollectionViewCell {

    static let identifier = "ImageFullScreenCollectionViewCell"
    
    @IBOutlet var imageView: UIImageView!
    
    var imageUrl: String? {
        didSet {
            setupImage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        scrollView.maximumZoomScale = 4
//        scrollView.minimumZoomScale = 1
//        
//        scrollView.delegate = self
    }
    
    func setupImage() {
        guard let urlImage = URL(string: "\(DomainNameConfig.TMSImagePath.urlString)\(imageUrl ?? "")") else { return }
        imageView.kf.setImageDefault(with: urlImage)
    }

}


//extension ImageFullScreenCollectionViewCell: UIScrollViewDelegate {
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return imageView
//    }
//
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        if scrollView.zoomScale > 1 {
//            if let image = imageView.image {
//                let ratioW = imageView.frame.width / image.size.width
//                let ratioH = imageView.frame.height / image.size.height
//
//                let ratio = ratioW < ratioH ? ratioW : ratioH
//
//                let newWidth = image.size.width * ratio
//                let newHeight = image.size.height * ratio
//
//                let conditionLeft = newWidth*scrollView.zoomScale > imageView.frame.width
//                let left = 0.5 * (conditionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
//                let conditioTop = newHeight*scrollView.zoomScale > imageView.frame.height
//
//                let top = 0.5 * (conditioTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
//
//                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
//            }
//        }
//    }
//}
