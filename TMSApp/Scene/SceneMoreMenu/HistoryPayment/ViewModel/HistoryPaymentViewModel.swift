//
//  HistoryPaymentViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/5/21.
//

import Foundation
import UIKit
import Combine

protocol HistoryPaymentProtocolInput {
    func getCreditPaymentFindAll()
    func setOrderId(orderId: Int?)
}

protocol HistoryPaymentProtocolOutput: class {
    var didGetOrderSuccess: (() -> Void)? { get set }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getItemOrder(index: Int) -> CreditPaymentItems?
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemViewCellHeight() -> CGFloat
}

protocol HistoryPaymentProtocol: HistoryPaymentProtocolInput, HistoryPaymentProtocolOutput {
    var input: HistoryPaymentProtocolInput { get }
    var output: HistoryPaymentProtocolOutput { get }
}

class HistoryPaymentViewModel: HistoryPaymentProtocol, HistoryPaymentProtocolOutput {
    var input: HistoryPaymentProtocolInput { return self }
    var output: HistoryPaymentProtocolOutput { return self }
    
    // MARK: - UseCase
    private var getCreditPaymentUseCase: GetCreditPaymentUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Properties
    private var vc: HistoryPaymentViewController
    
    init(
        vc: HistoryPaymentViewController,
         getCreditPaymentUseCase: GetCreditPaymentUseCase = GetCreditPaymentUseCaseImpl()
                 ) {
        self.getCreditPaymentUseCase = getCreditPaymentUseCase
        self.vc = vc
    }
    
    // MARK - Data-binding OutPut
    var didGetOrderSuccess: (() -> Void)?
    
    fileprivate var listCreditPaymentItems: [CreditPaymentItems]? = []
    fileprivate var orderId: Int?
    
    func getCreditPaymentFindAll() {
        self.listCreditPaymentItems?.removeAll()
        self.vc.startLoding()
        var request = GetCreditPaymentFindAllRequest()
        request.orderId = 5
        self.getCreditPaymentUseCase.execute(request: request).sink { completion in
            self.vc.stopLoding()
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "getCreditPaymentFindAll finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "getCreditPaymentFindAll failure")
                break
            }
            
        } receiveValue: { resp in
            debugPrint(resp)
            if let items = resp {
                self.listCreditPaymentItems = items
            }
            self.didGetOrderSuccess?()
        }.store(in: &self.anyCancellable)
    }
    
    func setOrderId(orderId: Int?) {
        self.orderId = orderId
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        guard let count = listCreditPaymentItems?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemOrder(index: Int) -> CreditPaymentItems? {
        guard let itemOrder = listCreditPaymentItems?[index] else { return nil }
        return itemOrder
    }
    
    func getItemViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryPaymentTableViewCell.identifier, for: indexPath) as! HistoryPaymentTableViewCell
        cell.selectionStyle = .none
        cell.item = listCreditPaymentItems?[indexPath.item]
        return cell
    }
    
    func getItemViewCellHeight() -> CGFloat {
        return 65
    }
}
