//
//  TypeUserDetailViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.input.getProduct()
    }
    
    func configure(_ interface: TypeUserDetailProtocol) {
        self.viewModel = interface
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
        
        registerCell()
    }
    
    
    fileprivate func registerCell() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.showsVerticalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let screenWidth = ((collectionView.frame.width - 40) / 2) - 16
        layout.itemSize = CGSize(width: screenWidth, height: 225)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
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
//        NavigationManager.instance.pushVC(to: .editEmployee)
    }
}


extension TypeUserDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItem")
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
