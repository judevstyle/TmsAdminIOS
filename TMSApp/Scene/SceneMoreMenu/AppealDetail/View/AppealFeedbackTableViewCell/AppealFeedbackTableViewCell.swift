//
//  AppealFeedbackTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/10/21.
//

import UIKit

protocol AppealFeedbackTableViewCellDelegate {
    func didSelectImage(index: Int?)
}

class AppealFeedbackTableViewCell: UITableViewCell {
    static let identifier = "AppealFeedbackTableViewCell"
    
    @IBOutlet weak var appealView: UIView!
    @IBOutlet var commentText: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    lazy public var imageItemCount = 0
    
    public var delegate: AppealFeedbackTableViewCellDelegate?
    
    let inset: CGFloat = 10
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow = 4
    
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
        registerCell()
        setupUI()
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
    
    public func setupValue() {
        self.imageItemCount = viewModel.output.getListImageCount()
        commentText.text = viewModel.output.getCommentText()
        debugPrint("Comment \(viewModel.output.getCommentText())")
        collectionView.reloadData()
    }
    
    fileprivate func registerCell() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.showsVerticalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView!.collectionViewLayout = layout
        collectionView?.contentInsetAdjustmentBehavior = .always
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

//        let lineHeight = String(format: "%.0f", Double(imageItemCount)/4.00 )
//        let roundedLineHeight = CGFloat((lineHeight as NSString).doubleValue)
//        collectionViewHeight.constant = roundedLineHeight * 91.5
        return viewModel.output.getNumberOfMenu()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.output.getItemViewCell(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectImage(index: indexPath.item)
    }
}


extension AppealFeedbackTableViewCell: UICollectionViewDelegateFlowLayout{
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
}
