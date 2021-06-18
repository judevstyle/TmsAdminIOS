//
//  SequenceShipmentViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import Foundation
import UIKit
import RxSwift

protocol SequenceShipmentProtocolInput {
    func getSequenceShipment()
    func swapItem(sourceIndex: Int, destinationIndex: Int)
}

protocol SequenceShipmentProtocolOutput: class {
    var didGetSequenceShipmentSuccess: (() -> Void)? { get set }
    var didGetSequenceShipmentError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol SequenceShipmentProtocol: SequenceShipmentProtocolInput, SequenceShipmentProtocolOutput {
    var input: SequenceShipmentProtocolInput { get }
    var output: SequenceShipmentProtocolOutput { get }
}

class SequenceShipmentViewModel: SequenceShipmentProtocol, SequenceShipmentProtocolOutput {
    
    var input: SequenceShipmentProtocolInput { return self }
    var output: SequenceShipmentProtocolOutput { return self }
    
    // MARK: - Properties
    private var sequenceShipmentViewController: SequenceShipmentViewController
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        sequenceShipmentViewController: SequenceShipmentViewController
    ) {
        self.sequenceShipmentViewController = sequenceShipmentViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetSequenceShipmentSuccess: (() -> Void)?
    var didGetSequenceShipmentError: (() -> Void)?
    
    fileprivate var listSequenceShipment: [GetAppealResponse]? = []
    
    func getSequenceShipment() {
        listSequenceShipment?.removeAll()
        sequenceShipmentViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<3 {
                weakSelf.listSequenceShipment?.append(GetAppealResponse(title: "test"))
            }

            weakSelf.didGetSequenceShipmentSuccess?()
            weakSelf.sequenceShipmentViewController.stopLoding()
        }
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listSequenceShipment?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SequenceShipmentTableViewCell.identifier, for: indexPath) as! SequenceShipmentTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func swapItem(sourceIndex: Int, destinationIndex: Int) {
        self.listSequenceShipment?.swapAt(sourceIndex, destinationIndex)
    }
}
