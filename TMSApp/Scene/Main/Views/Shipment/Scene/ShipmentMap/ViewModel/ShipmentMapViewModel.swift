//
//  ShipmentMapViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/21/21.
//

import Foundation
import RxSwift
import UIKit
import GoogleMaps


protocol ShipmentMapProtocolInput {
    func getShipmentMap()
    func didSelectMarkerAt(_ mapView: GMSMapView, marker: GMSMarker) -> Bool
}

protocol ShipmentMapProtocolOutput: class {
    var didGetShipmentMapSuccess: (() -> Void)? { get set }
    var didGetShipmentDetailError: (() -> Void)? { get set }
    
    func getListMarkerMap() -> [GetShipmentMapResponse]
}

protocol ShipmentMapProtocol: ShipmentMapProtocolInput, ShipmentMapProtocolOutput {
    var input: ShipmentMapProtocolInput { get }
    var output: ShipmentMapProtocolOutput { get }
}

class ShipmentMapViewModel: ShipmentMapProtocol, ShipmentMapProtocolOutput {
    
    var input: ShipmentMapProtocolInput { return self }
    var output: ShipmentMapProtocolOutput { return self }
    
    // MARK: - Properties
    //    private var getProductUseCase: GetProductUseCase
    private var shipmentMapViewController: ShipmentMapViewController
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        //        getProductUseCase: GetProductUseCase = GetProductUseCaseImpl(),
        shipmentMapViewController: ShipmentMapViewController
    ) {
        //        self.getProductUseCase = getProductUseCase
        self.shipmentMapViewController = shipmentMapViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetShipmentMapSuccess: (() -> Void)?
    var didGetShipmentDetailError: (() -> Void)?
    
    fileprivate var listMarker: [GetShipmentMapResponse]? = []
    
    func getShipmentMap() {
        shipmentMapViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            
            weakSelf.listMarker?.append(GetShipmentMapResponse(title: "001", lat: 13.663517, long: 100.607846))
            weakSelf.listMarker?.append(GetShipmentMapResponse(title: "002", lat: 13.662474, long: 100.605250))
            weakSelf.listMarker?.append(GetShipmentMapResponse(title: "003", lat: 13.660087, long: 100.608973))
            weakSelf.listMarker?.append(GetShipmentMapResponse(title: "004", lat: 13.661536, long: 100.614262))
            
            weakSelf.didGetShipmentMapSuccess?()
            weakSelf.shipmentMapViewController.stopLoding()
        }
    }
    
    func didSelectMarkerAt(_ mapView: GMSMapView, marker: GMSMarker) -> Bool {
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let customView = PopupMarkerMapView(frame: CGRect(x: 0, y: 0, width: alertController.view.bounds.width-16, height: 204))
        alertController.view.addSubview(customView)
        alertController.view.backgroundColor = .white
        alertController.view.layer.cornerRadius = 8
        alertController.view.layer.masksToBounds = true
        alertController.view.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.heightAnchor.constraint(equalToConstant: customView.frame.height).isActive = true
        
        customView.backgroundColor = .green
        
        
        alertController.editingInteractionConfiguration
        
        shipmentMapViewController.present(alertController, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alertController.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
        
        return true
    }
    
    func getListMarkerMap() -> [GetShipmentMapResponse] {
        guard let markers = self.listMarker else { return [] }
        return markers
    }
}

extension ShipmentMapViewModel {
    @objc func dismissAlertController() {
        shipmentMapViewController.dismiss(animated: true, completion: nil)
    }
}


