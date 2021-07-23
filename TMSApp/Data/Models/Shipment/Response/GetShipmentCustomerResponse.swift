//
//  GetShipmentCustomerResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 26/6/2564 BE.
//

import Foundation

public struct GetShipmentCustomerResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: [ShipmentCustomerItems]?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

//public struct ShipmentCustomerData: Codable, Hashable  {
//
//    public var shipmentId: Int?
//    public var planId: Int?
//    public var planSeq: Int?
//    public var shipmentNo: String?
//    public var status: Int?
//    public var shipmentCustomer: [ShipmentCustomerItems]?
//    public var shipmentStock: [ShipmentStockItems]?
//    public var planMaster: [PlanMasterItems]?
//
//    public init() {}
//
//    public init(from decoder: Decoder) throws {
//        try shipmentId        <- decoder["shipment_id"]
//        try planId            <- decoder["plan_id"]
//        try planSeq           <- decoder["plan_seq"]
//        try shipmentNo        <- decoder["shipment_no"]
//        try status            <- decoder["status"]
//        try shipmentCustomer  <- decoder["shipmentCustomer"]
//        try shipmentStock     <- decoder["shipmentStock"]
//        try planMaster        <- decoder["planMaster"]
//    }
//}

public struct ShipmentCustomerItems: Codable, Hashable  {
    
    public var shipmentCusId: Int?
    public var shipmentId: Int?
    public var cusId: Int?
    public var express: Bool?
    public var seq: Int?
    public var statusSend: Int?
    public var statusSendRemark: String?
    public var customer: CustomerItems?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try shipmentCusId   <- decoder["shipment_cus_id"]
        try shipmentId       <- decoder["shipment_id"]
        try cusId            <- decoder["cus_id"]
        try express           <- decoder["express"]
        try seq               <- decoder["seq"]
        try statusSend       <- decoder["status_send"]
        try statusSendRemark       <- decoder["status_send_remark"]
        try customer          <- decoder["customer"]
    }
}

public struct TypeUser: Codable, Hashable  {
    
    public var typeUserId: Int?
    public var compId: Int?
    public var typeName: String?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try typeUserId    <- decoder["type_user_id"]
        try compId         <- decoder["comp_id"]
        try typeName       <- decoder["type_name"]
    }
}
