//
//  AppealDetailViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/10/21.
//

import Foundation
import UIKit
import Combine

protocol AppealDetailProtocolInput {
    func setItemFeedback(item: FeedbackItems)
    func getItemFeedbackDetail()
}

protocol AppealDetailProtocolOutput: class {
    var didGetFeedbackDetailSuccess: (() -> Void)? { get set }
    
    func getNumberOfAppeal(section: Int) -> Int
    func getItemAppeal(index: Int) -> GetAppealResponse?
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemViewCellHeight(section: Int) -> CGFloat
    
    func getHeightSectionView(section: Int) -> CGFloat
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView?
    
    func getItemFeedback() -> FeedbackItems?
}

protocol AppealDetailProtocol: AppealDetailProtocolInput, AppealDetailProtocolOutput {
    var input: AppealDetailProtocolInput { get }
    var output: AppealDetailProtocolOutput { get }
}

class AppealDetailViewModel: AppealDetailProtocol, AppealDetailProtocolOutput {
    var input: AppealDetailProtocolInput { return self }
    var output: AppealDetailProtocolOutput { return self }
    
    // MARK: - Properties
    private var getFeedbackOneUseCase: GetFeedbackOneUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private var appealDetailViewController: AppealDetailViewController
    
    
    init(
        appealDetailViewController: AppealDetailViewController,
        getFeedbackOneUseCase: GetFeedbackOneUseCase = GetFeedbackOneUseCaseImpl()
    ) {
        self.appealDetailViewController = appealDetailViewController
        self.getFeedbackOneUseCase = getFeedbackOneUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetFeedbackDetailSuccess: (() -> Void)?
    
    fileprivate var listAppeal: [GetAppealResponse]? = []
    fileprivate var itemFeedback: FeedbackItems? = nil
    fileprivate var itemFeedbackDetail: FeedbackItems? = nil
    
    func setItemFeedback(item: FeedbackItems) {
        self.itemFeedback = item
    }
    
    func getItemFeedbackDetail() {
        itemFeedbackDetail = nil
        appealDetailViewController.startLoding()
        guard let item = self.itemFeedback else { return }
        var  request: GetFeedbackOneRequest = GetFeedbackOneRequest()
        request.feedbackId = item.feedId
        self.getFeedbackOneUseCase.execute(request: request).sink { completion in
            debugPrint("getFeedbackOne \(completion)")
            self.appealDetailViewController.stopLoding()
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "getCustomer finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "getCustomer failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp?.data {
                self.itemFeedbackDetail = items
                self.didGetFeedbackDetailSuccess?()
            }
        }.store(in: &self.anyCancellable)
    }
    
    func getItemFeedback() -> FeedbackItems? {
        return self.itemFeedback
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
            cell.delegate = self
            cell.imageItemCount = 3
            cell.viewModel.input.setData(listImage: ["", "", ""], comment: "asdasdasdasdasasd")
            cell.setupValue()
            return cell
        }
    }
    
    func getItemViewCellHeight(section: Int) -> CGFloat {
        switch section {
        case 0:
            return 91
        default:
            return 250
        }
    }
    
    func getHeightSectionView(section: Int) -> CGFloat {
        return 25
    }
    
    func getHeaderViewCell(_ tableView: UITableView, section: Int) -> UIView? {
        let header = HeaderPrimaryBottomLineViewCell()
        if section == 0 {
            header.setState(title: "จัดส่งโดย", isEdit: false, section: section)
        } else {
            header.setState(title: "คะแนนการทำงาน", isEdit: false, section: section)
        }
        return header
    }
}


extension AppealDetailViewModel:  AppealFeedbackTableViewCellDelegate {
    func didSelectImage(index: Int?) {
        
        //Mock
        let urlImage = itemFeedback?.order?.customer?.avatar
        let listImage: [String?] = [urlImage, urlImage, urlImage, urlImage, urlImage]
        
        NavigationManager.instance.pushVC(to: .imageListScroll(listImage: listImage, index: index), presentation: .presentFullSceen(completion: nil))
    }
}
