//
//  AppealFeedbackViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/13/21.
//

import Foundation
import UIKit

protocol AppealFeedbackProtocolInput {
    func setData(listImage: [String], comment: String)
}

protocol AppealFeedbackProtocolOutput: class {
    var didGetAppealSuccess: (() -> Void)? { get set }
    var didGetAppealError: (() -> Void)? { get set }

    func getNumberOfMenu() -> Int
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    
    func getCommentText() -> String
    func getListImageCount() -> Int
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
    
    
    init(
        appealFeedbackTableViewCell: AppealFeedbackTableViewCell
    ) {
        self.appealFeedbackTableViewCell = appealFeedbackTableViewCell
    }
    
    // MARK - Data-binding OutPut
    var didGetAppealSuccess: (() -> Void)?
    var didGetAppealError: (() -> Void)?
    
    fileprivate var listImage: [String]? = []
    fileprivate var comment: String?

    
    func setData(listImage: [String], comment: String) {
        self.listImage = listImage
        self.comment = comment
    }

    func getNumberOfMenu() -> Int {
        return self.listImage?.count ?? 0
    }
    
    func getCommentText() -> String {
        return self.comment ?? ""
    }
    
    func getListImageCount() -> Int {
        return self.listImage?.count ?? 0
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
