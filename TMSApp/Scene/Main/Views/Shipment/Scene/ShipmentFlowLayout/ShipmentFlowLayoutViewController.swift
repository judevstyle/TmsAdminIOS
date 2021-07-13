//
//  ShipmentFlowLayoutViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/13/21.
//

import UIKit
import HMSegmentedControl

class ShipmentFlowLayoutViewController: UIViewController {

    @IBOutlet var topnavView: UIView!
    @IBOutlet var pageCollectionView: UICollectionView!
    
    let segmentedControl = HMSegmentedControl()
    var currentPage: Int = 0
    
    // ViewModel
    lazy var viewModel: ShipmentFlowLayoutProtocol = {
        let vm = ShipmentFlowLayoutViewModel(shipmentFlowLayoutViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTopnav()
        setupPageCollectionView()
    }
    
    func configure(_ interface: ShipmentFlowLayoutProtocol) {
        self.viewModel = interface
    }
    
}

// MARK: - Binding
extension ShipmentFlowLayoutViewController {
    func bindToViewModel() {
    }
}


//MARK:- SegmentedControl
extension ShipmentFlowLayoutViewController {
    
    private func setupTopnav() {

        segmentedControl.sectionTitles = [
            "รายละเอียด",
            "สินค้า",
        ]
        
        segmentedControl.frame = CGRect(x: 0, y: 12, width: 170, height: 35)
        segmentedControl.selectionIndicatorLocation = .bottom
        segmentedControl.selectionIndicatorColor = .Primary
        segmentedControl.contentVerticalAlignment = .center
        segmentedControl.enlargeEdgeInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let segmentedFont = UIFont.PrimaryText(size: 17)
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.font: segmentedFont, NSAttributedString.Key.foregroundColor: UIColor.Primary]
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        view.addSubview(segmentedControl)
        topnavView.addSubview(segmentedControl)
    }
    
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        let selectedIndexPath = IndexPath(item: Int(selectedSegmentIndex), section: 0)
        pageCollectionView.scrollToItem(at: selectedIndexPath, at: .bottom, animated: true)
    }
}

//MARK:- PageCollectionView
extension ShipmentFlowLayoutViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func setupPageCollectionView() {

        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pageCollectionView.showsHorizontalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.sectionInsetReference = .fromSafeArea
        pageCollectionView.collectionViewLayout = layout
        pageCollectionView.contentInsetAdjustmentBehavior = .always
        pageCollectionView.isPagingEnabled = true
        pageCollectionView.backgroundColor = .clear
        
        pageCollectionView.registerCell(identifier: ShipmentDetailViewCell.identifier)
        pageCollectionView.registerCell(identifier: ShipmentProductCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfItemsInSection(collectionView, section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.output.getCellForItemAt(collectionView, indexPath: indexPath)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pageCollectionView.frame.width, height: pageCollectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = view.frame.width
        let currentPage = UInt(pageCollectionView.contentOffset.x/pageWidth)
        segmentedControl.setSelectedSegmentIndex(currentPage, animated: true)
    }
}
