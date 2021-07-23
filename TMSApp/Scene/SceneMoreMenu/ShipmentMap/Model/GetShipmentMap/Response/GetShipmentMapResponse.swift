//
//  GetShipmentMapResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/21/21.
//

import Foundation
import GoogleMaps

public struct GetShipmentMapResponse: Codable {
    
    public var title: String?
    public var lat: Double?
    public var long: Double?
//    public var location: CLLocationCoordinate2D?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case lat = "lat"
        case long = "long"
//        case location = "location"
    }
}
