//
//  PutShipmentRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/15/21.
//

import Foundation

public struct PutShipmentRequest: Codable, Hashable {
    
    public var planId: Int?
    public var status: Int = 1
    public var shipmentCustomer: [ShipmentCustomerRequest]?
    public var shipmentStock: [ShipmentStockRequest]?
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case planId = "plan_id"
        case status = "status"
        case shipmentCustomer = "shipment_customer"
        case shipmentStock = "shipment_stock"
    }
}

public struct ShipmentCustomerRequest: Codable, Hashable {
    
    public var shipmentCusId: Int?
    public var cusId: Int?
    public var seq: Int?
    public var statusSend: Int = 1
    public var statusSendRemark: String = ""
    public var express: Bool = false
    public var del: Int = 1

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case shipmentCusId = "shipment_cus_id"
        case cusId = "cus_id"
        case seq = "seq"
        case statusSend = "status_send"
        case statusSendRemark = "status_send_remark"
        case express = "express"
        case del = "del"
    }
}

public struct ShipmentStockRequest: Codable, Hashable {
    
    public var shipmentStockId: Int?
    public var productId: Int?
    public var qty: String?
    public var statusSend: Int?
    public var statusSendRemark: String?
    public var del: Int = 1

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case shipmentStockId = "shipment_stock_id"
        case productId = "product_id"
        case qty = "qty"
        case statusSend = "status_send"
        case statusSendRemark = "status_send_remark"
        case del = "del"
    }
}
