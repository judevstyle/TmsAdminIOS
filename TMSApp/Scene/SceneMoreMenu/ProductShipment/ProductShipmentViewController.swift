//
//  ProductShipmentViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/3/21.
//

import UIKit
import HMSegmentedControl

class ProductShipmentViewController: UIViewController {
    
    @IBOutlet var TopInfoView: UIView!
    @IBOutlet var topnavView: UIView!
    @IBOutlet var pageCollectionView: UICollectionView!
    
    //Info
    @IBOutlet var InfoImageView: UIImageView!
    @IBOutlet var InfoNoLabel: UILabel!
    @IBOutlet var InfoNameLabel: UILabel!
    @IBOutlet var InfoLocation: UILabel!
    @IBOutlet var InfoDistance: UILabel!
    @IBOutlet var InfoTime: UILabel!
    
    let segmentedControl = HMSegmentedControl()
    var currentPage: Int = 0
    
    // ViewModel
    lazy var viewModel: ProductShipmentProtocol = {
        let vm = ProductShipmentViewModel(productShipmentViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        setupTopnav()
        setupPageCollectionView()
    }
    
    func configure(_ interface: ProductShipmentProtocol) {
        self.viewModel = interface
    }


    override func viewWillAppear(_ animated: Bool) {
//        pageCollectionView.reloadData()
    }
}

// MARK: - Binding
extension ProductShipmentViewController {
    func bindToViewModel() {
    }
}


//MARK:- SegmentedControl
extension ProductShipmentViewController {
    
    func setupUI() {
        TopInfoView.roundCorners(corners: .bottomLeft, radius: 30)
        
        InfoImageView.setRounded(rounded: 8)
    }
    
    private func setupTopnav() {

        segmentedControl.sectionTitles = [
            "บิลวันนี้",
            "รายการค้างชำระ",
        ]
        
        segmentedControl.frame = CGRect(x: 0, y: 12, width: topnavView.frame.width, height: 35)
        segmentedControl.selectionIndicatorLocation = .bottom
        segmentedControl.selectionIndicatorColor = .Primary
        segmentedControl.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl.selectionStyle = .fullWidthStripe
        segmentedControl.contentVerticalAlignment = .center
        segmentedControl.enlargeEdgeInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
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
extension ProductShipmentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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

        pageCollectionView.registerCell(identifier: BillNowCollectionViewCell.identifier)
        pageCollectionView.registerCell(identifier: BillPaymentCollectionViewCell.identifier)
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
