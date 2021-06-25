//
//  GetShipmentResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/15/21.
//

import Foundation

public struct GetShipmentResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: ShipmentData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct ShipmentData: Codable, Hashable  {
    
    public var items: [ShipmentItems]?
    public var meta: MetaObject?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try items    <- decoder["items"]
        try meta     <- decoder["meta"]
    }
}

public struct ShipmentItems: Codable, Hashable  {
    
    public var shipmentId: Int?
    public var status: Int?
    public var planId: Int?
    public var employeeName: String?
    public var employeeImg: String?
    public var planName: String?
    public var shipmentNo: String?
    public var truckRegistrationNumber: String?
    public var customerShipmentNumber: SummaryCustomer?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try shipmentId                 <- decoder["shipment_id"]
        try status                     <- decoder["status"]
        try planId                     <- decoder["plan_id"]
        try employeeName               <- decoder["employee_name"]
        try employeeImg                <- decoder["employee_img"]
        try planName                   <- decoder["plan_name"]
        try shipmentNo                 <- decoder["shipment_no"]
        try truckRegistrationNumber    <- decoder["truck_registration_number"]
        try customerShipmentNumber     <- decoder["customerShipmentNumber"]
    }
}

