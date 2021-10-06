//
//  TypeUserDetailViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit
import MaterialComponents

class TypeUserDetailViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleTopView: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var addProductButton: UIButton!
    
    // ViewModel
    lazy var viewModel: TypeUserDetailProtocol = {
        let vm = TypeUserDetailViewModel(typeUserDetailViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    let inset: CGFloat = 10
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func configure(_ interface: TypeUserDetailProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.getProduct()
    }
}

// MARK: - Binding
extension TypeUserDetailViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetProductSuccess = didGetProductSuccess()
    }
    
    func didGetProductSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.collectionView.reloadData()
        }
    }
}

// MARK: - SETUP UI
extension TypeUserDetailViewController {
    func setupUI() {
        topView.setRounded(rounded: 8)
        addProductButton.setRounded(rounded: 8)
        addProductButton.addTarget(self, action: #selector(btnAddProduct), for: .touchUpInside)
        
        editButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        if let item = viewModel.output.getItemDetial() {
            titleTopView.text = item.typeName ?? ""
        }
        titleTopView.sizeToFit()
        registerCell()
    }
    
    
    fileprivate func registerCell() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.showsVerticalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView!.collectionViewLayout = layout
        collectionView.registerCell(identifier: ProductCollectionViewCell.identifier)
    }
}

// MARK: - Handles
extension TypeUserDetailViewController {
    @objc func btnEditTitle() {
        //        NavigationManager.instance.pushVC(to: .editEmployee)
    }
    
    @objc func btnAddProduct() {
        let item = viewModel.output.getItemDetial()
        NavigationManager.instance.pushVC(to: .typeUserProductAll(item: item, shipmentId: nil))
    }
}


extension TypeUserDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let itemTypeUser = viewModel.getItemDetial(),
              let itemProductSpecial = viewModel.getItem(index: indexPath.item)  else { return }
        NavigationManager.instance.pushVC(to: .typeUserProductDetail(
                                            itemTypeUser: itemTypeUser,
                                            itemProduct: nil,
                                            itemProductSpecial: itemProductSpecial,
                                            typeAction: .update, delegate: self), presentation: .BottomSheet(completion: {
            
        }, height: 620))
    }
    
}

extension TypeUserDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfCollection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.output.getItemViewCell(collectionView, indexPath: indexPath)
    }
}


extension TypeUserDetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth + 85)
    }
}

extension TypeUserDetailViewController: TypeUserProductDetailViewModelDelegate {
    func didConfirmmNewProductComplete() {
        viewModel.input.getProduct()
    }
}
