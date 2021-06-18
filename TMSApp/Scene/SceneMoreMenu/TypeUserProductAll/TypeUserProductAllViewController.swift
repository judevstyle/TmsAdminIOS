//
//  TypeUserProductAllViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import UIKit

class TypeUserProductAllViewController: UIViewController {

    @IBOutlet var headerCollectionView: UICollectionView!
    @IBOutlet var productCollectionView: UICollectionView!
    
    // ViewModel
    lazy var viewModel: TypeUserProductAllProtocol = {
        let vm = TypeUserProductAllViewModel(typeUserProductAllViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.input.getCategory()
    }
    
    func configure(_ interface: TypeUserProductAllProtocol) {
        self.viewModel = interface
    }
}

// MARK: - Binding
extension TypeUserProductAllViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetCategorySuccess = didGetCategorySuccess()
        viewModel.output.didGetProductSuccess = didGetProductSuccess()
    }
    
    func didGetCategorySuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.headerCollectionView.reloadData()
            let selectedIndexPath = IndexPath(item: 0, section: 0)
            weakSelf.headerCollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: [])
            weakSelf.viewModel.input.getProduct(cmsId: "")
        }
    }
    
    func didGetProductSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.productCollectionView.reloadData()
        }
    }
}

// MARK: - SETUP UI
extension TypeUserProductAllViewController {
    func setupUI() {

    
        
        registerHeaderCell()
        registerProductCell()
    }
    
    fileprivate func registerHeaderCell() {
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        headerCollectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        headerCollectionView.showsVerticalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let screenWidth = ((headerCollectionView.frame.width - 16) / 6) - 4
//        layout.itemSize = CGSize(width: screenWidth, height: 75)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        headerCollectionView!.collectionViewLayout = layout
        headerCollectionView.registerCell(identifier: ProductCategoryCollectionViewCell.identifier)
    }
    
    
    fileprivate func registerProductCell() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        productCollectionView.showsVerticalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let screenWidth = ((productCollectionView.frame.width - 16) / 2) - 8
        layout.itemSize = CGSize(width: screenWidth, height: 225)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        productCollectionView!.collectionViewLayout = layout
        productCollectionView.registerCell(identifier: ProductCollectionViewCell.identifier)
    }
}

// MARK: - Handles
extension TypeUserProductAllViewController {

}


extension TypeUserProductAllViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch collectionView {
        case headerCollectionView:
            self.viewModel.input.didSelectItemAt(collectionView, indexPath: indexPath, type: .category)
        case productCollectionView:
            self.viewModel.input.didSelectItemAt(collectionView, indexPath: indexPath, type: .product)
        default:
            self.viewModel.input.didSelectItemAt(collectionView, indexPath: indexPath, type: .product)
        }
    }
    
}

extension TypeUserProductAllViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case headerCollectionView:
            return self.viewModel.output.getItemViewCell(collectionView, indexPath: indexPath, type: .category)
        case productCollectionView:
            return self.viewModel.output.getItemViewCell(collectionView, indexPath: indexPath, type: .product)
        default:
            return self.viewModel.output.getItemViewCell(collectionView, indexPath: indexPath, type: .category)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case headerCollectionView:
            return self.viewModel.output.getNumberOfCollection(type: .category)
        case productCollectionView:
            return self.viewModel.output.getNumberOfCollection(type: .product)
        default:
            return self.viewModel.output.getNumberOfCollection(type: .category)
        }
    }
}
