//
//  TypeUserViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

protocol TypeUserProtocolInput {
    func getTypeUser()
}

protocol TypeUserProtocolOutput: class {
    var didGetTypeUserSuccess: (() -> Void)? { get set }
    var didGetTypeUserError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol TypeUserProtocol: TypeUserProtocolInput, TypeUserProtocolOutput {
    var input: TypeUserProtocolInput { get }
    var output: TypeUserProtocolOutput { get }
}

class TypeUserViewModel: TypeUserProtocol, TypeUserProtocolOutput {
    var input: TypeUserProtocolInput { return self }
    var output: TypeUserProtocolOutput { return self }
    
    // MARK: - Properties
    private var typeUserViewController: TypeUserViewController
    
    
    
    init(
        typeUserViewController: TypeUserViewController
    ) {
        self.typeUserViewController = typeUserViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetTypeUserSuccess: (() -> Void)?
    var didGetTypeUserError: (() -> Void)?
    
    fileprivate var listTypeUser: [GetAppealResponse]? = []
    
    func getTypeUser() {
        listTypeUser?.removeAll()
        typeUserViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<3 {
                weakSelf.listTypeUser?.append(GetAppealResponse(title: "test"))
            }

            weakSelf.didGetTypeUserSuccess?()
            weakSelf.typeUserViewController.stopLoding()
        }
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listTypeUser?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TypeUserTableViewCell.identifier, for: indexPath) as! TypeUserTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}
