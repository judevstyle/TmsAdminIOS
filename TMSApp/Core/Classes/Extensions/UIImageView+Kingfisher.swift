//
//  UIImageView+Kingfisher.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 26/6/2564 BE.
//

import Foundation
import Kingfisher
import UIKit

extension KingfisherWrapper where Base : Kingfisher.KFCrossPlatformImageView {
    func setImageDefault(with urlImage: URL){
        self.setImage(with: urlImage,
                      placeholder: UIImage(named: "placeholder"),
                      options: [
                        .loadDiskFileSynchronously,
                        .cacheOriginalImage,
                        .transition(.fade(0.15))],
                      progressBlock: { receivedSize, totalSize in
                        
                      },
                      completionHandler: { result in
                        
                      })
    }
}
