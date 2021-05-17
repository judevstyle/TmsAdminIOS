//
//  MenuViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/15/21.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // ViewModel
    lazy var viewModel: MenuProtocol = {
        let vm = MenuViewModel(menuViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
    }
    
    func configure(_ interface: MenuProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.getMenu()
    }
}

// MARK: - Binding
extension MenuViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetMenuSuccess = didGetMenuSuccess()
        viewModel.output.didGetMenuError = didGetMenuError()
    }
    
    func didGetMenuSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.collectionView.reloadData()
        }
    }
    
    func didGetMenuError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.collectionView.reloadData()
        }
    }
}

extension MenuViewController {
    func setupUI(){
    }
    
    fileprivate func registerCell() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.showsVerticalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let screenWidth = ((collectionView.frame.width - 40) / 4) - 16
        layout.itemSize = CGSize(width: screenWidth, height: screenWidth)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        collectionView!.collectionViewLayout = layout
        collectionViewRegister(identifier: MenuCollectionViewCell.identifier)
    }
    
    fileprivate func collectionViewRegister(identifier: String) {
        self.collectionView.register(UINib.init(nibName: identifier, bundle: Bundle.main), forCellWithReuseIdentifier: identifier)
    }
}

extension MenuViewController: UICollectionViewDelegate {

}

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfMenu()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.output.getItemViewCell(collectionView, indexPath: indexPath)
    }
}
