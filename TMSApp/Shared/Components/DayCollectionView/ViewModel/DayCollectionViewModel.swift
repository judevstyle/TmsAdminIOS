//
//  DayCollectionViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import Foundation
import RxSwift
import UIKit

protocol DayCollectionViewModelDelegate {
    func listSelectedDay(days: [WeeklyType]?)
}

protocol DayCollectionProtocolInput {
    func setList(days: [WeeklyType]?)
    func didSelectItemAt(_ collectionView: UICollectionView, indexPath: IndexPath)
    func setDelegate(delegate: DayCollectionViewModelDelegate)
}

protocol DayCollectionProtocolOutput: class {
    var didSetMenuSuccess: (() -> Void)? { get set }
    
    func getNumberOfCollection() -> Int
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

protocol DayCollectionProtocol: DayCollectionProtocolInput, DayCollectionProtocolOutput {
    var input: DayCollectionProtocolInput { get }
    var output: DayCollectionProtocolOutput { get }
}

class DayCollectionViewModel: DayCollectionProtocol, DayCollectionProtocolOutput {
    var input: DayCollectionProtocolInput { return self }
    var output: DayCollectionProtocolOutput { return self }
    
    // MARK: - Properties
    
    init(
    ) {
    }
    
    // MARK - Data-binding OutPut
    var didSetMenuSuccess: (() -> Void)?
    fileprivate var listDay: [WeeklyType]? = []
    fileprivate var listSelectedDay: [WeeklyType]? = []
    
    public var delegate: DayCollectionViewModelDelegate?
    
    func setDelegate(delegate: DayCollectionViewModelDelegate) {
        self.delegate = delegate
    }
    
    func setList(days: [WeeklyType]?) {
        listDay = days
        self.didSetMenuSuccess?()
    }
    
    func getNumberOfCollection() -> Int {
        guard let count = listDay?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayListCollectionViewCell.identifier, for: indexPath) as! DayListCollectionViewCell
        cell.titleText.text = self.listDay?[indexPath.row].title ?? ""
        return cell
    }
    
    
    func didSelectItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DayListCollectionViewCell {
            cell.setState()
            if cell.isSelectedItem {
                addSelectedDay(day: (self.listDay?[indexPath.row]))
            } else {
                deleteSelectedDay(day: (self.listDay?[indexPath.row]))
            }
            self.delegate?.listSelectedDay(days: self.listSelectedDay)
        }
    }
    
    func addSelectedDay(day: WeeklyType?) {
        guard let day = day else { return }
        self.listSelectedDay?.append(day)
        
    }
    func deleteSelectedDay(day: WeeklyType?) {
        guard let day = day, let list = self.listSelectedDay else { return }

        for (index, item) in list.enumerated() {
            if item == day {
                self.listSelectedDay?.remove(at: index)
                return
            }
        }
    }
}

