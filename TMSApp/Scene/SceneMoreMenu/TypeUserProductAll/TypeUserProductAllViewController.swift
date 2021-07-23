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
    
    let inset: CGFloat = 10
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow = 2
    
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
        ShipmentStockManager.shared.setListSelectShipmentStock(items: [])
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
        
        
        
        //Mock UI
        if viewModel.output.getItemTypeUser() == nil {
            let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didSaveShipmentStock))
            button.tintColor = .white
            navigationItem.rightBarButtonItem = button
        }
    }
    
    @objc func didSaveShipmentStock() {
        viewModel.input.didSaveShipmentStock()
    }
    
    fileprivate func registerHeaderCell() {
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        headerCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        headerCollectionView.showsVerticalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        headerCollectionView.collectionViewLayout = layout
        headerCollectionView.registerCell(identifier: ProductCategoryCollectionViewCell.identifier)
    }
    
    
    fileprivate func registerProductCell() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        productCollectionView.showsVerticalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        productCollectionView.collectionViewLayout = layout
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

extension TypeUserProductAllViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case headerCollectionView:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case productCollectionView:
            return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case headerCollectionView:
            return 0
        case productCollectionView:
            return minimumLineSpacing
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case headerCollectionView:
            return 0
        case productCollectionView:
            return minimumInteritemSpacing
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
    
        switch collectionView {
        case headerCollectionView:
            var sizeWidthHead: CGFloat = 0
            let font = UIFont.PrimaryText(size: 17)
            let fontAttributes = [NSAttributedString.Key.font: font]
            let myText = viewModel.output.getTitleCategory(indexPath: indexPath)
            let sizeWidth = (myText as NSString).size(withAttributes: fontAttributes)
            sizeWidthHead = sizeWidth.width + 8 + 16 + 16 + 8
            return CGSize(width: sizeWidthHead, height: 60)
        case productCollectionView:
            return CGSize(width: itemWidth, height: itemWidth + 85)
        default:
            return CGSize(width: itemWidth, height: itemWidth + 85)
        }
    }
}
