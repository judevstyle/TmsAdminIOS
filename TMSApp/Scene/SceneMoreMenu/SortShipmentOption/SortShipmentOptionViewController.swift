//
//  SortShipmentOptionViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/15/21.
//

import UIKit

class SortShipmentOptionViewController: UIViewController {

    @IBOutlet var viewExpress: UIView!
    @IBOutlet var viewDelete: UIView!
    
    // ViewModel
    lazy var viewModel: SortShipmentOptionProtocol = {
        let vm = SortShipmentOptionViewModel(sortShipmentOptionViewController: self)
        self.configure(vm)
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func configure(_ interface: SortShipmentOptionProtocol) {
        self.viewModel = interface
    }


    func setupView() {
        let tapViewExpress = UITapGestureRecognizer(target: self, action: #selector(self.handleTapViewExpress))
        viewExpress.addGestureRecognizer(tapViewExpress)
        viewExpress.isUserInteractionEnabled = true
        
        let tapViewDelete = UITapGestureRecognizer(target: self, action: #selector(self.handleTapViewDelete))
        viewDelete.addGestureRecognizer(tapViewDelete)
        viewDelete.isUserInteractionEnabled = true
    }
    
    @objc func handleTapViewExpress() {
        viewModel.input.didExpress()
    }
    
    @objc func handleTapViewDelete() {
        viewModel.input.didDelete()
    }
}
