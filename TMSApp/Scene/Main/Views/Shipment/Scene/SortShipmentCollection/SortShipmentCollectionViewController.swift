//
//  SortShipmentCollectionViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import UIKit

class SortShipmentCollectionViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var btnSave: ButtonPrimaryView!

    let inset: CGFloat = 10
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow = 3
    
    // ViewModel
    lazy var viewModel: SortShipmentProtocol = {
        let vm = SortShipmentViewModel(sortShipmentCollectionViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
    }
    
    func configure(_ interface: SortShipmentProtocol) {
        self.viewModel = interface
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.getShipmentCustomer()
    }
}

// MARK: - Binding
extension SortShipmentCollectionViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetShipmentCustomer = didGetShipmentCustomer()
        viewModel.output.didEditActionSuccess = didEditActionSuccess()
    }
    
    func didGetShipmentCustomer() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.collectionView.reloadData()
        }
    }
    
    func didEditActionSuccess() -> ((ShipmentCustomerItems?) -> Void) {
        return { [weak self] item in
            guard let weakSelf = self else { return }
            NavigationManager.instance.pushVC(to: .sortShipmentOption(delegate: weakSelf, item: item), presentation: .BottomSheet(completion: {
            }, height: 124))
        }
    }
}

extension SortShipmentCollectionViewController: SortShipmentOptionViewModelDelegate {
    func didTapFastExpress(item: ShipmentCustomerItems?) {
        viewModel.input.didTapExpressCustomer(item: item)
    }
    
    func didDeleteCustomer(item: ShipmentCustomerItems?) {
        viewModel.input.didTapDeleteCustomer(item: item)
    }
}

extension SortShipmentCollectionViewController {
    
    func setupUI() {
        btnSave.setTitle(title: "บันทึกการเปลี่ยนแปลง")
        btnSave.delegate = self
        
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didAddCustomer))
        button.tintColor = .white
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func didAddCustomer() {
        guard let item = viewModel.output.getShipmentItem() else { return }
        NavigationManager.instance.pushVC(to: .selectCustomer(shipmentId: item.shipmentId))
    }
    
    fileprivate func registerCell() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.showsVerticalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView?.collectionViewLayout = layout
        collectionView?.contentInsetAdjustmentBehavior = .always
        collectionView.registerCell(identifier: ShipmentCustomerCollectionViewCell.identifier)
        
        let gesture = UILongPressGestureRecognizer(target: self,
                                                   action: #selector(handleLongPress))
        
        collectionView.addGestureRecognizer(gesture)
    }
    
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let collectionView = collectionView else { return }
        
        
        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else { return }
            
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
        
    }
}


extension SortShipmentCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

}

extension SortShipmentCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfCollectionCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.output.getItemViewCell(collectionView, indexPath: indexPath)
    }
}

extension SortShipmentCollectionViewController: UICollectionViewDelegateFlowLayout{
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
    
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    //Re-Order
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.input.moveItemAt(collectionView, sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath)
    }
}


extension SortShipmentCollectionViewController: ButtonPrimaryViewDelegate {
    func onClickButton() {
        viewModel.input.saveShipmentCustomer()
    }
}
