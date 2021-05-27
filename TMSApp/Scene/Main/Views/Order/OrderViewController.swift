//
//  OrderViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/15/21.
//

import UIKit
import HMSegmentedControl

class OrderViewController: UIViewController {
    
    @IBOutlet weak var SegmentedControlView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // ViewModel
    lazy var viewModel: OrderProtocol = {
        let vm = OrderViewModel(orderViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    let segmentedControl = HMSegmentedControl()
    var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        setUpNavigationPage()
    }
    
    func configure(_ interface: OrderProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.getOrder(request: GetOrderRequest(title: ""))
    }
}

// MARK: - Binding
extension OrderViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetOrderSuccess = didGetOrderSuccess()
        viewModel.output.didGetOrderError = didGetOrderError()
    }
    
    func didGetOrderSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.collectionView.reloadData()
            weakSelf.segmentedControl.sectionTitles = weakSelf.viewModel.output.getSectionTitles()
        }
    }
    
    func didGetOrderError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.collectionView.reloadData()
        }
    }
}

extension OrderViewController {
    func setupUI(){
    }
    
    fileprivate func registerCell() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInsetReference = .fromSafeArea
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.collectionViewLayout = layout
        
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionRegister(identifier: OrderCollectionViewCell.identifier)
    }
    
    fileprivate func collectionRegister(identifier: String) {
        self.collectionView.register(UINib.init(nibName: identifier, bundle: Bundle.main), forCellWithReuseIdentifier: identifier)
    }
    
    func setUpNavigationPage() {
        
        segmentedControl.frame = CGRect(x: 0, y: 0, width: SegmentedControlView.frame.width, height: SegmentedControlView.frame.height)
        segmentedControl.contentVerticalAlignment = .center
        segmentedControl.selectionIndicatorColor = UIColor.Primary
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.font: UIFont.PrimaryText(size: 16), NSAttributedString.Key.foregroundColor: UIColor.gray]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedString.Key.font: UIFont.PrimaryText(size: 16), NSAttributedString.Key.foregroundColor: UIColor.Primary]
        segmentedControl.selectionIndicatorLocation = .bottom
        segmentedControl.selectionIndicatorHeight = 2
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        SegmentedControlView.addSubview(segmentedControl)
    }
    
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        if segmentedControl.selectedSegmentIndex > self.currentPage {
            self.currentPage = Int(segmentedControl.selectedSegmentIndex)
            pageSelected(index: self.currentPage, animated: true, position: .left)
        }else {
            self.currentPage = Int(segmentedControl.selectedSegmentIndex)
            pageSelected(index: self.currentPage, animated: true, position: .right)
        }
    }
}


//MARK:- Page
extension OrderViewController {
    
    func pageSelected(index: Int, animated: Bool, position: UICollectionView.ScrollPosition) {
          let scrollIndex: NSIndexPath = NSIndexPath(item: index, section: 0)
          collectionView.scrollToItem(at: scrollIndex as IndexPath, at: position, animated: animated)
          currentPage = index
      }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = view.frame.width
        currentPage = Int(collectionView.contentOffset.x/pageWidth)
        segmentedControl.selectedSegmentIndex = UInt(currentPage)
    }
}


extension OrderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfOrderPage()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.output.getCollectionViewCell(collectionView, indexPath: indexPath)
    }
}
