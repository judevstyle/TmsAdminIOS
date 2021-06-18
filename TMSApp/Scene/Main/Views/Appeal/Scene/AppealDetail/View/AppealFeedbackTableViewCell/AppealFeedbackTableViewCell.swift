//
//  AppealFeedbackTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/10/21.
//

import UIKit

class AppealFeedbackTableViewCell: UITableViewCell {
    static let identifier = "AppealFeedbackTableViewCell"
    
    @IBOutlet weak var appealView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    lazy public var imageItemCount = 0
    
    // ViewModel
    lazy var viewModel: AppealFeedbackProtocol = {
        let vm = AppealFeedbackViewModel(appealFeedbackTableViewCell: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        registerCell()
        viewModel.input.getAppeal(request: GetAppealRequest())
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(_ interface: AppealFeedbackProtocol) {
        self.viewModel = interface
    }
}

extension AppealFeedbackTableViewCell {
    func setupUI(){
//        appealView.setRounded(rounded: 8)
//        appealView.layer.shadowColor = UIColor.darkGray.cgColor
//        appealView.layer.shadowOpacity = 0.5
//        appealView.layer.shadowOffset = .zero
//        appealView.layer.shadowRadius = 3
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
        collectionViewRegister(identifier: ImageFeedbackCollectionViewCell.identifier)
    }
    
    fileprivate func collectionViewRegister(identifier: String) {
        self.collectionView.register(UINib.init(nibName: identifier, bundle: Bundle.main), forCellWithReuseIdentifier: identifier)
    }
}

// MARK: - Binding
extension AppealFeedbackTableViewCell {
    
    func bindToViewModel() {
        viewModel.output.didGetAppealSuccess = didGetMenuSuccess()
        viewModel.output.didGetAppealError = didGetMenuError()
    }
    
    func didGetMenuSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.collectionView.reloadData()
            weakSelf.collectionView.updateConstraints()
        }
    }
    
    func didGetMenuError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.collectionView.reloadData()
        }
    }
}

extension AppealFeedbackTableViewCell: UICollectionViewDelegate {
    
}

extension AppealFeedbackTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let lineHeight = String(format: "%.0f", Double(imageItemCount)/4.00 )
        let roundedLineHeight = CGFloat((lineHeight as NSString).doubleValue)
        collectionViewHeight.constant = roundedLineHeight * 91.5
        return viewModel.output.getNumberOfMenu()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.output.getItemViewCell(collectionView, indexPath: indexPath)
    }
}
