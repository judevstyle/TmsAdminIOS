//
//  AppealDetailViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/10/21.
//

import Foundation
import UIKit

protocol AppealDetailProtocolInput {
    func getAppeal(request: GetAppealRequest)
}

protocol AppealDetailProtocolOutput: class {
    var didGetAppealSuccess: (() -> Void)? { get set }
    var didGetAppealError: (() -> Void)? { get set }
    
    func getNumberOfAppeal(section: Int) -> Int
    func getItemAppeal(index: Int) -> GetAppealResponse?
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemViewCellHeight(section: Int) -> CGFloat
    
    func getHeightSectionView(section: Int) -> CGFloat
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView?
}

protocol AppealDetailProtocol: AppealDetailProtocolInput, AppealDetailProtocolOutput {
    var input: AppealDetailProtocolInput { get }
    var output: AppealDetailProtocolOutput { get }
}

class AppealDetailViewModel: AppealDetailProtocol, AppealDetailProtocolOutput {
    var input: AppealDetailProtocolInput { return self }
    var output: AppealDetailProtocolOutput { return self }
    
    // MARK: - Properties
//    private var getProductUseCase: GetProductUseCase
    private var appealDetailViewController: AppealDetailViewController
    
    
    init(
        appealDetailViewController: AppealDetailViewController
    ) {
        self.appealDetailViewController = appealDetailViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetAppealSuccess: (() -> Void)?
    var didGetAppealError: (() -> Void)?
    
    fileprivate var listAppeal: [GetAppealResponse]? = []
    
    func getAppeal(request: GetAppealRequest) {
        listAppeal?.removeAll()
        appealDetailViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<3 {
                weakSelf.listAppeal?.append(GetAppealResponse(title: "test"))
            }

            weakSelf.didGetAppealSuccess?()
            weakSelf.appealDetailViewController.stopLoding()
        }
    }
    
    func getNumberOfAppeal(section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 1
        }
    }
    
    func getItemAppeal(index: Int) -> GetAppealResponse? {
        guard let itemAppeal = listAppeal?[index] else { return nil }
        return itemAppeal
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AppealSentByTableViewCell.identifier, for: indexPath) as! AppealSentByTableViewCell
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: AppealFeedbackTableViewCell.identifier, for: indexPath) as! AppealFeedbackTableViewCell
            cell.selectionStyle = .none
            cell.imageItemCount = 15
            return cell
        }
    }
    
    func getItemViewCellHeight(section: Int) -> CGFloat {
        switch section {
        case 0:
            return 91
        default:
            return UITableView.automaticDimension
        }
        return 91
    }
    
    func getHeightSectionView(section: Int) -> CGFloat {
        return 25
    }
    
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderPrimaryBottomLineTableViewCell.identifier)
        if let header = header as? HeaderPrimaryBottomLineTableViewCell {
            if section == 0 {
                header.setState(title: "จัดส่งโดย", isEdit: false, section: section)
            } else {
                header.setState(title: "คะแนนการทำงาน", isEdit: false, section: section)
            }
        }
        return header
    }
}
