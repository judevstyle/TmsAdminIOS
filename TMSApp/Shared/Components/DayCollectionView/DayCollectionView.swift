//
//  DayCollectionView.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import UIKit

class DayCollectionView: UIView {
    
    let nibName = "DayCollectionView"
    var contentView:UIView?
    
    // ViewModel
    lazy var viewModel: DayCollectionProtocol = {
        let vm = DayCollectionViewModel()
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    @IBOutlet var collectionView: UICollectionView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupUI()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func configure(_ interface: DayCollectionProtocol) {
        self.viewModel = interface
    }
}

// MARK: - Binding
extension DayCollectionView {
    
    func bindToViewModel() {
        viewModel.output.didSetMenuSuccess = didSetMenuSuccess()
        viewModel.output.didSetSelectDailySuccess = didSetSelectDailySuccess()
    }
    
    func didSetMenuSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.collectionView.reloadData()
            let selectedIndexPath = IndexPath(item: 0, section: 0)
            weakSelf.collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: [])
        }
    }
    
    func didSetSelectDailySuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.collectionView.reloadData()
        }
    }
}

extension DayCollectionView {
    func setupUI() {
        registerCell()
    }
    
    fileprivate func registerCell() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.showsVerticalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let screenWidth = ((collectionView.frame.width - 0) / 9)
        layout.itemSize = CGSize(width: screenWidth, height: 50)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        collectionView!.collectionViewLayout = layout
        collectionView.registerCell(identifier: DayListCollectionViewCell.identifier)
    }
    
}


extension DayCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.input.didSelectItemAt(collectionView, indexPath: indexPath)
    }
    
}

extension DayCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfCollection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.output.getItemViewCell(collectionView, indexPath: indexPath)
    }
}


public enum WeeklyType {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
    
    public var title: String {
        switch self {
        case .Monday:
            return "???."
        case .Tuesday:
            return "???."
        case .Wednesday:
            return "???."
        case .Thursday:
            return "??????."
        case .Friday:
            return "???."
        case .Saturday:
            return "???."
        case .Sunday:
            return "??????."
        }
    }
    
    public var id: Int {
        switch self {
        case .Monday:
            return 1
        case .Tuesday:
            return 2
        case .Wednesday:
            return 3
        case .Thursday:
            return 4
        case .Friday:
            return 5
        case .Saturday:
            return 6
        case .Sunday:
            return 7
        }
    }
}
