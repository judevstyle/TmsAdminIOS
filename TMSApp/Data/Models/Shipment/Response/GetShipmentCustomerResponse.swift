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
    public var data: ShipmentCustomerData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct ShipmentCustomerData: Codable, Hashable  {
    
    public var shipmentId: Int?
    public var planId: Int?
    public var planSeq: Int?
    public var shipmentNo: String?
    public var status: Int?
    public var shipmentCustomer: [ShipmentCustomerItems]?
    public var shipmentStock: [ShipmentStockItems]?
    public var planMaster: [PlanMasterItems]?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try shipmentId        <- decoder["shipment_id"]
        try planId            <- decoder["plan_id"]
        try planSeq           <- decoder["plan_seq"]
        try shipmentNo        <- decoder["shipment_no"]
        try status            <- decoder["status"]
        try shipmentCustomer  <- decoder["shipmentCustomer"]
        try shipmentStock     <- decoder["shipmentStock"]
        try planMaster        <- decoder["planMaster"]
    }
}


public struct ShipmentCustomerItems: Codable, Hashable  {
    
    public var shipmentCusId: Int?
    public var shipmentId: Int?
    public var cusId: Int?
    public var express: Bool?
    public var seq: Int?
    public var statusSend: Int?
    public var customer: CustomerItems?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try shipmentCusId   <- decoder["shipment_cus_id"]
        try shipmentId       <- decoder["shipment_id"]
        try cusId            <- decoder["cus_id"]
        try express           <- decoder["express"]
        try seq               <- decoder["seq"]
        try statusSend       <- decoder["status_send"]
        try customer          <- decoder["customer"]
    }
}

public struct CustomerItems: Codable, Hashable  {
    
    public var cusId: Int?
    public var tel: String?
    public var typeUserId: Int?
    public var compId: Int?
    public var displayName: String?
    public var fname: String?
    public var lname: String?
    public var address: String?
    public var lat: Double?
    public var lng: Double?
    public var avatar: String?
    public var typeUser: TypeUser?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try cusId         <- decoder["cus_id"]
        try tel           <- decoder["tel"]
        try typeUserId    <- decoder["type_user_id"]
        try compId        <- decoder["comp_id"]
        try displayName   <- decoder["display_name"]
        try fname         <- decoder["fname"]
        try lname         <- decoder["lname"]
        try address       <- decoder["address"]
        try lat           <- decoder["lat"]
        try lng           <- decoder["lng"]
        try avatar        <- decoder["avatar"]
        try typeUser      <- decoder["typeUser"]
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

public struct ShipmentStockItems: Codable, Hashable  {
    
    public var shipmentStockId: Int?
    public var shipmentId: Int?
    public var productId: Int?
    public var qty: Int?
    public var status: String?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try shipmentStockId  <- decoder["shipment_stock_id"]
        try shipmentId       <- decoder["shipment_id"]
        try productId        <- decoder["product_id"]
        try qty              <- decoder["qty"]
        try status           <- decoder["status"]
    }
}
