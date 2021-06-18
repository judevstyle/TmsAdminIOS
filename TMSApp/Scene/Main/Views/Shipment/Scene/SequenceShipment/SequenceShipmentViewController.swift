//
//  SequenceShipmentViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import UIKit

class SequenceShipmentViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnSort: UIBarButtonItem!
    
    // ViewModel
    lazy var viewModel: SequenceShipmentProtocol = {
        let vm = SequenceShipmentViewModel(sequenceShipmentViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        viewModel.input.getSequenceShipment()
    }
    
    func configure(_ interface: SequenceShipmentProtocol) {
        self.viewModel = interface
    }
    
    @IBAction func didTapSort(_ sender: Any) {
        if tableView.isEditing {
            btnSort.image = UIImage(systemName: "square.and.pencil")
        }else {
            btnSort.image = UIImage(systemName: "checkmark")
        }
        
        tableView.isEditing = !tableView.isEditing
        
    }
}

// MARK: - Binding
extension SequenceShipmentViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetSequenceShipmentSuccess = didGetSequenceShipmentSuccess()
        viewModel.output.didGetSequenceShipmentError = didGetSequenceShipmentError()
    }
    
    func didGetSequenceShipmentSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
    
    func didGetSequenceShipmentError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}

// MARK: - SETUP UI
extension SequenceShipmentViewController {
    func setupUI() {
        
    }
    
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.registerCell(identifier: SequenceShipmentTableViewCell.identifier)
    }
    
}

// MARK: - Handles
extension SequenceShipmentViewController {
    
}


extension SequenceShipmentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.output.getHeightForRowAt(tableView, indexPath: indexPath)
    }
    
}


extension SequenceShipmentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.input.swapItem(sourceIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
}
