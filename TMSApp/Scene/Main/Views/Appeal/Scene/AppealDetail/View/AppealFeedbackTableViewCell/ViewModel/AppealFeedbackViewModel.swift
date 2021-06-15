//
//  AppealFeedbackViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/13/21.
//

import Foundation
import RxSwift
import UIKit

protocol AppealFeedbackProtocolInput {
    func getAppeal(request: GetAppealRequest)
}

protocol AppealFeedbackProtocolOutput: class {
    var didGetAppealSuccess: (() -> Void)? { get set }
    var didGetAppealError: (() -> Void)? { get set }

    func getNumberOfMenu() -> Int
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

protocol AppealFeedbackProtocol: AppealFeedbackProtocolInput, AppealFeedbackProtocolOutput {
    var input: AppealFeedbackProtocolInput { get }
    var output: AppealFeedbackProtocolOutput { get }
}

class AppealFeedbackViewModel: AppealFeedbackProtocol, AppealFeedbackProtocolOutput {
    var input: AppealFeedbackProtocolInput { return self }
    var output: AppealFeedbackProtocolOutput { return self }
    
    // MARK: - Properties
//    private var getProductUseCase: GetProductUseCase
    private var appealFeedbackTableViewCell: AppealFeedbackTableViewCell
    fileprivate let disposeBag = DisposeBag()
    
    init(
        appealFeedbackTableViewCell: AppealFeedbackTableViewCell
    ) {
        self.appealFeedbackTableViewCell = appealFeedbackTableViewCell
    }
    
    // MARK - Data-binding OutPut
    var didGetAppealSuccess: (() -> Void)?
    var didGetAppealError: (() -> Void)?
    
    fileprivate var listFeedback: [GetAppealResponse]? = []
    
    func getAppeal(request: GetAppealRequest) {
        listFeedback?.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<6 {
                weakSelf.listFeedback?.append(GetAppealResponse(title: "test"))
            }
            weakSelf.didGetAppealSuccess?()
        }
    }
    
    func getNumberOfMenu() -> Int {
        return self.listFeedback?.count ?? 0
    }
    
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageFeedbackCollectionViewCell.identifier, for: indexPath) as! ImageFeedbackCollectionViewCell

        return cell
    }
    
    
    func getSizeItemViewCell() -> CGSize {
        let width = UIScreen.main.bounds.width / 4
        return CGSize(width: width, height: width)
    }
    

}
