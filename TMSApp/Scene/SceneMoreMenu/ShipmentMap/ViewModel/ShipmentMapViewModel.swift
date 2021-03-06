//
//  ShipmentMapViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/21/21.
//

import Foundation
import UIKit
import GoogleMaps


protocol ShipmentMapProtocolInput {
    func getShipmentMap()
    func didSelectMarkerAt(_ mapView: GMSMapView, marker: GMSMarker) -> Bool
    func fetchMapMarker()
}

protocol ShipmentMapProtocolOutput: class {
    var didGetShipmentMapSuccess: (() -> Void)? { get set }
    var didGetShipmentDetailError: (() -> Void)? { get set }
    
    func getMapMarkerResponse() -> [MarkerMapItems]?
    
    var didGetMapMarkerSuccess: (() -> Void)? { get set }
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
    
    var didGetMapMarkerSuccess: (() -> Void)?
    
    private var dataMapMarker: SocketMarkerMapResponse?
    
    func getShipmentMap() {

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
}

//MARK:- Fetch Socket
extension ShipmentMapViewModel {
    
    func getMapMarkerResponse() -> [MarkerMapItems]? {
        return self.dataMapMarker?.data
    }
    
    func fetchMapMarker() {
        SocketHelper.shared.fetchTrackingByComp { result in
            switch result {
            case .success(let resp):
                self.dataMapMarker = resp
                self.didGetMapMarkerSuccess?()
            case .failure(_ ):
                break
            }
        }
        emitMapMarker()
    }
    
    private func emitMapMarker(){
        var request: SocketMarkerMapRequest = SocketMarkerMapRequest()
        request.compId = 1
        SocketHelper.shared.emitTrackingByComp(request: request) {
            debugPrint("requestTrackingByComp\(request)")
        }
    }
}

extension ShipmentMapViewModel {
    @objc func dismissAlertController() {
        shipmentMapViewController.dismiss(animated: true, completion: nil)
    }
}


