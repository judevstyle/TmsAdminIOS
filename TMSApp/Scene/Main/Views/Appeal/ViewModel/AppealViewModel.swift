//
//  AppealViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/18/21.
//

import Foundation
import UIKit
import Combine

protocol AppealProtocolInput {
    func getFeedback()
}

protocol AppealProtocolOutput: class {
    var didGetAppealSuccess: (() -> Void)? { get set }
    var didGetAppealError: (() -> Void)? { get set }
    
    func getNumberOfAppeal() -> Int
    func getItemAppeal(index: Int) -> FeedbackItems?
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
    
    
    // MARK: - UseCase
    private var getFeedbackAllUseCase: GetFeedbackAllUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    // MARK: - Properties
//    private var getProductUseCase: GetProductUseCase
    private var appealViewController: AppealViewController
    
    init(
        getFeedbackAllUseCase: GetFeedbackAllUseCase = GetFeedbackAllUseCaseImpl(),
        appealViewController: AppealViewController
    ) {
        self.getFeedbackAllUseCase = getFeedbackAllUseCase
        self.appealViewController = appealViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetAppealSuccess: (() -> Void)?
    var didGetAppealError: (() -> Void)?
    
    fileprivate var listFeedbacks: [FeedbackItems]? = []
    
    func getFeedback() {
        self.listFeedbacks?.removeAll()
        self.appealViewController.startLoding()
        
        self.getFeedbackAllUseCase.execute().sink { completion in
            self.appealViewController.stopLoding()
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetOrder finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "GetOrder failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp?.items {
                self.listFeedbacks = items
            }
            self.didGetAppealSuccess?()
        }.store(in: &self.anyCancellable)
    }
    
    func getNumberOfAppeal() -> Int {
        guard let count = listFeedbacks?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemAppeal(index: Int) -> FeedbackItems? {
        guard let itemAppeal = listFeedbacks?[index] else { return nil }
        return itemAppeal
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppealTableViewCell.identifier, for: indexPath) as! AppealTableViewCell
        cell.selectionStyle = .none
        cell.items = self.listFeedbacks?[indexPath.item]
        return cell
    }
    
    func getItemViewCellHeight() -> CGFloat {
        return 110
    }
}
