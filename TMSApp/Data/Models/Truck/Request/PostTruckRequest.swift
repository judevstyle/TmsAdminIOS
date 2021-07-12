//
//  PostTruckRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/10/21.
//

import Foundation

public struct PostTruckRequest: Codable, Hashable {
    
    public var compId: Int?
    public var truckTitle: String?
    public var truckDesc: String?
    public var registrationNumber: String?
    public var truckImg: TruckImgRequest?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case compId = "comp_id"
        case truckTitle = "truck_title"
        case truckDesc = "truck_desc"
        case registrationNumber = "registration_number"
        case truckImg = "truck_img"
    }
}

public struct TruckImgRequest: Codable, Hashable {
    
    public var url: String?
    public var del: Int = 0
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case del = "del"
    }
}
