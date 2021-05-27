//
//  ShipmentMapViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/20/21.
//

import UIKit
import GoogleMaps

class ShipmentMapViewController: UIViewController {

    
    // ViewModel
    lazy var viewModel: ShipmentMapProtocol = {
        let vm = ShipmentMapViewModel(shipmentMapViewController: self)
        self.configure(vm)
        self.bindToViewModel()
        return vm
    }()
    
    var mapView: GMSMapView!
    var markerAll: GMSMarker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMap()
        NavigationManager.instance.setupWithNavigationController(navigationController: self.navigationController)
    }
    
    func configure(_ interface: ShipmentMapProtocol) {
        self.viewModel = interface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.getShipmentMap()
    }
    
}

// MARK: - setupView
extension ShipmentMapViewController {
    func setupUI(){
    }
    
    func setupMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 13.663491595353403, longitude: 100.6061463206966, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self
        self.view.addSubview(mapView)
    }
    
    func fetchMarkerMap(markers: [GetShipmentMapResponse]){
        for (index, marker) in markers.enumerated() {
            let position = CLLocationCoordinate2D(latitude: marker.lat ?? 0.0, longitude: marker.long ?? 0.0)
            markerAll = GMSMarker(position: position)
            markerAll.snippet = "\(index)"
            markerAll.isTappable = true
            markerAll.iconView =  MarkerMapView.instantiate(index: index, message: marker.title ?? "")
            markerAll.tracksViewChanges = true
            self.markerAll.map = self.mapView
        }
    }
}

// MARK: - Binding
extension ShipmentMapViewController {
    
    func bindToViewModel() {
        viewModel.output.didGetShipmentMapSuccess = didGetShipmentMapSuccess()
        viewModel.output.didGetShipmentDetailError = didGetShipmentDetailError()
    }
    
    func didGetShipmentMapSuccess() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
            let markers = weakSelf.viewModel.output.getListMarkerMap()
            weakSelf.fetchMarkerMap(markers: markers)
        }
    }
    
    func didGetShipmentDetailError() -> (() -> Void) {
        return { [weak self] in
            guard let weakSelf = self else { return }
        }
    }
}
extension ShipmentMapViewController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let markerView = marker.iconView as? MarkerMapView else { return false }
        return viewModel.input.didSelectMarkerAt(mapView, marker: marker)
    }
}
