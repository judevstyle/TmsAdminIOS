//
//  TypeUserViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit
import Combine

protocol TypeUserProtocolInput {
    func getTypeUser()
}

protocol TypeUserProtocolOutput: class {
    var didGetTypeUserSuccess: (() -> Void)? { get set }
    var didGetTypeUserError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
    func getItemRowAt(_ tableView: UITableView, indexPath: IndexPath) -> TypeUserData?
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
    // MARK: - UseCase
    private var getTypeUserUseCase: GetTypeUserUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(
        typeUserViewController: TypeUserViewController,
        getTypeUserUseCase: GetTypeUserUseCase = GetTypeUserUseCaseImpl()
    ) {
        self.typeUserViewController = typeUserViewController
        self.getTypeUserUseCase = getTypeUserUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetTypeUserSuccess: (() -> Void)?
    var didGetTypeUserError: (() -> Void)?
    
    fileprivate var listTypeUser: [TypeUserData]? = []
    
    func getTypeUser() {
        listTypeUser?.removeAll()
        typeUserViewController.startLoding()
        self.getTypeUserUseCase.execute().sink { completion in
            debugPrint("getTypeUser \(completion)")
        } receiveValue: { resp in
            self.listTypeUser = resp
            self.didGetTypeUserSuccess?()
            self.typeUserViewController.stopLoding()
        }.store(in: &self.anyCancellable)
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
        cell.items = self.listTypeUser?[indexPath.item]
        return cell
    }
    
    func getItemRowAt(_ tableView: UITableView, indexPath: IndexPath) -> TypeUserData? {
        return self.listTypeUser?[indexPath.item]
    }
}
