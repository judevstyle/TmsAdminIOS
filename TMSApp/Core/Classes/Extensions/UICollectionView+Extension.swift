//
//  UICollectionView+Extension.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

extension UICollectionView {
    func registerCell(identifier: String) {
        self.register(UINib.init(nibName: identifier, bundle: Bundle.main), forCellWithReuseIdentifier: identifier)
    }
}

