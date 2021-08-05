//
//  ImageListScrollViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/6/21.
//

import Foundation
import UIKit
import Combine

protocol ImageListScrollProtocolInput {
    func setListImage(listImage: [String?])
    func setSelectedIndex(index: Int?)
    func fetchListImage()
}

protocol ImageListScrollProtocolOutput: class {
    var didFetchListImageSuccess: (() -> Void)? { get set }
    
    func getCellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func getNumberOfItemsInSection() -> Int
    
    func getSelectedIndex() -> Int
}

protocol ImageListScrollProtocol: ImageListScrollProtocolInput, ImageListScrollProtocolOutput {
    var input: ImageListScrollProtocolInput { get }
    var output: ImageListScrollProtocolOutput { get }
}

class ImageListScrollViewModel: ImageListScrollProtocol, ImageListScrollProtocolOutput {
    
    var input: ImageListScrollProtocolInput { return self }
    var output: ImageListScrollProtocolOutput { return self }
    
    // MARK: - Properties
    private var imageListScrollViewController: ImageListScrollViewController
    
    init(
        imageListScrollViewController: ImageListScrollViewController
    ) {
        self.imageListScrollViewController = imageListScrollViewController
    }
    
    // MARK - Data-binding OutPut
    var didFetchListImageSuccess: (() -> Void)?
    
    fileprivate var listImage: [String?] = []
    fileprivate var selectedIndex: Int?
    
    func fetchListImage() {
        didFetchListImageSuccess?()
    }
    
    func setListImage(listImage: [String?]) {
        self.listImage = listImage
    }
    
    func getSelectedIndex() -> Int {
        return selectedIndex ?? 0
    }
    
    func setSelectedIndex(index: Int?) {
        self.selectedIndex = index
    }
    
    func getNumberOfItemsInSection() -> Int {
        return self.listImage.count
    }
    
    func getCellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageFullScreenCollectionViewCell.identifier, for: indexPath) as! ImageFullScreenCollectionViewCell
        cell.imageUrl = self.listImage[indexPath.item]
        return cell
    }
    
}
