//
//  DayCollectionViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import Foundation
import UIKit

protocol DayCollectionViewModelDelegate {
    func listSelectedDay(days: [WeeklyType])
}

protocol DayCollectionProtocolInput {
    func setList(days: [WeeklyType])
    func didSelectItemAt(_ collectionView: UICollectionView, indexPath: IndexPath)
    func setDelegate(delegate: DayCollectionViewModelDelegate)
    func setEdit(isEdit: Bool)
    func setSelectDailys(days: [WeeklyType])
}

protocol DayCollectionProtocolOutput: class {
    var didSetMenuSuccess: (() -> Void)? { get set }
    var didSetSelectDailySuccess: (() -> Void)? { get set }
    
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
    var didSetSelectDailySuccess: (() -> Void)?
    
    fileprivate var listDay: [WeeklyType] = []
    fileprivate var listSelectedDay: [WeeklyType] = []
    fileprivate var isEditing: Bool = false
    
    public var delegate: DayCollectionViewModelDelegate?
    
    func setDelegate(delegate: DayCollectionViewModelDelegate) {
        self.delegate = delegate
    }
    
    func setList(days: [WeeklyType]) {
        listDay = days
        self.didSetMenuSuccess?()
    }
    
    func setSelectDailys(days: [WeeklyType]) {
        listSelectedDay = days
        self.didSetSelectDailySuccess?()
    }
    
    func setEdit(isEdit: Bool) {
        self.isEditing = isEdit
    }
    
    func getNumberOfCollection() -> Int {
        guard listDay.count != 0 else { return 0 }
        return listDay.count
    }
    
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayListCollectionViewCell.identifier, for: indexPath) as! DayListCollectionViewCell
        cell.titleText.text = self.listDay[indexPath.row].title ?? ""
        for item in self.listSelectedDay {
            if item == self.listDay[indexPath.item] {
                cell.setState()
            }
        }
        return cell
    }
    
    
    func didSelectItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DayListCollectionViewCell, isEditing == true {
            cell.setState()
            if cell.isSelectedItem {
                addSelectedDay(day: (self.listDay[indexPath.row]))
            } else {
                deleteSelectedDay(day: (self.listDay[indexPath.row]))
            }
            self.delegate?.listSelectedDay(days: self.listSelectedDay)
        }
    }
    
    func addSelectedDay(day: WeeklyType?) {
        guard let day = day else { return }
        self.listSelectedDay.append(day)
        
    }
    func deleteSelectedDay(day: WeeklyType?) {
        guard let day = day else { return }

        for (index, item) in self.listSelectedDay.enumerated() {
            if item == day {
                self.listSelectedDay.remove(at: index)
                return
            }
        }
    }
}

