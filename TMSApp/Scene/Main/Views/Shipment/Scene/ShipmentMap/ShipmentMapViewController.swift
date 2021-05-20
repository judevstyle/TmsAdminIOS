//
//  ShipmentMapViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/20/21.
//

import UIKit
import GoogleMaps

class ShipmentMapViewController: UIViewController {
    
    let markerView: UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 49, height: 49))
        let pin = UIImage(named: "map-customer")!.withRenderingMode(.alwaysTemplate)
        let size = CGSize(width: 45, height: 45)
        imageView.image = pin
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self
        mapView.mapType = .satellite
        self.view.addSubview(mapView)
        
        
        let positionLondon = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        let marker = GMSMarker(position: positionLondon)
        let viewMarker = MarkerMapView.instantiate(message: "Nontawat")
        marker.iconView = viewMarker
        marker.isTappable = true
        marker.map = mapView
        
    }
}

extension ShipmentMapViewController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let markerView = marker.iconView as? MarkerMapView else { return false }
        print("Nontawat \(markerView.Title.text ?? "")")
        return true
    }
}
