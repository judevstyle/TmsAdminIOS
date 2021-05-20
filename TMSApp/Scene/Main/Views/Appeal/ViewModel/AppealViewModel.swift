//
//  AppealViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/18/21.
//

import Foundation
import RxSwift
import UIKit

protocol AppealProtocolInput {
    func getAppeal(request: GetAppealRequest)
}

protocol AppealProtocolOutput: class {
    var didGetAppealSuccess: (() -> Void)? { get set }
    var didGetAppealError: (() -> Void)? { get set }
    
    func getNumberOfAppeal() -> Int
    func getItemAppeal(index: Int) -> GetAppealResponse?
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemViewCellHeight() -> CGFloat
}

protocol AppealProtocol: AppealProtocolInput, AppealProtocolOutput {
    var input: AppealProtocolInput { get }
    var output: AppealProtocolOutput { get }
}

class AppealViewModel: AppealProtocol, AppealProtocolOutput {
    var input: AppealProtocolInput { return self }
    var output: AppealProtocolOutput { return self }
    
    // MARK: - Properties
//    private var getProductUseCase: GetProductUseCase
    private var appealViewController: AppealViewController
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
//        getProductUseCase: GetProductUseCase = GetProductUseCaseImpl(),
        appealViewController: AppealViewController
    ) {
//        self.getProductUseCase = getProductUseCase
        self.appealViewController = appealViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetAppealSuccess: (() -> Void)?
    var didGetAppealError: (() -> Void)?
    
    fileprivate var listAppeal: [GetAppealResponse]? = []
    
    func getAppeal(request: GetAppealRequest) {
        listAppeal?.removeAll()
        appealViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<3 {
                weakSelf.listAppeal?.append(GetAppealResponse(title: "test"))
            }

            weakSelf.didGetAppealSuccess?()
            weakSelf.appealViewController.stopLoding()
        }
    }
    
    func getNumberOfAppeal() -> Int {
        guard let count = listAppeal?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemAppeal(index: Int) -> GetAppealResponse? {
        guard let itemAppeal = listAppeal?[index] else { return nil }
        return itemAppeal
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppealTableViewCell.identifier, for: indexPath) as! AppealTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func getItemViewCellHeight() -> CGFloat {
        return 91
    }
}
