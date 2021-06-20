//
//  MainViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/5/21.
//

import Foundation
import RxSwift
import UIKit

protocol MainProtocolInput {
    func getHome()
}

protocol MainProtocolOutput: class {
    var didGetHomeSuccess: (() -> Void)? { get set }
    var didGetHomeError: (() -> Void)? { get set }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemViewCellHeight(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getHeightSectionView(section: Int) -> CGFloat
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView?
}

protocol MainProtocol: MainProtocolInput, MainProtocolOutput {
    var input: MainProtocolInput { get }
    var output: MainProtocolOutput { get }
}

class MainViewModel: MainProtocol, MainProtocolOutput {
    var input: MainProtocolInput { return self }
    var output: MainProtocolOutput { return self }
    
    // MARK: - Properties
    private var mainViewController: MainViewController
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        mainViewController: MainViewController
    ) {
        self.mainViewController = mainViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetHomeSuccess: (() -> Void)?
    var didGetHomeError: (() -> Void)?
    
    func getHome() {
        mainViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<7 {
            }

            weakSelf.didGetHomeSuccess?()
            weakSelf.mainViewController.stopLoding()
        }
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainDashBoardTableViewCell.identifier, for: indexPath) as! MainDashBoardTableViewCell
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func getItemViewCellHeight(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            let height = (tableView.frame.width - 24)/4
            return height
        default:
            return 40
        }
    }
    
    func getHeightSectionView(section: Int) -> CGFloat {
        let headerHeight: CGFloat
        switch section {
        case 0:
            // hide the header
            headerHeight = CGFloat.leastNonzeroMagnitude
        default:
            headerHeight = 25
        }
        return headerHeight
    }
    
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderPrimaryBottomLineTableViewCell.identifier)
            if let header = header as? HeaderPrimaryBottomLineTableViewCell {
                if section == 1 {
                    header.setState(title: "รายการขายสินค้า", isEdit: false, section: section)
                } else {
                    header.setState(title: "กำลังทำงาน", isEdit: false, section: section)
                }
            }
            return header
        }
    }
}
