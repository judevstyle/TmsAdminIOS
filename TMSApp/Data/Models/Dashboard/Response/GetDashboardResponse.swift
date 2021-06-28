//
//  GetDashboardResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 25/6/2564 BE.
//

import Foundation

public struct GetDashboardResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: DashboardData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct DashboardData: Codable, Hashable  {
    
    public var totalOrderProduct: [TotalOrderProduct]?
    public var summaryCustomer: SummaryCustomer?
    public var employeeWork: [EmployeeWork]?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try totalOrderProduct    <- decoder["total_order_product"]
        try summaryCustomer      <- decoder["summary_customer"]
        try employeeWork         <- decoder["employee_work"]
    }
}

public struct SummaryCustomer: Codable, Hashable  {
    
    public var totalCustomer: Int = 0
    public var totalSended: Int = 0
    public var totalSendNotSuccess: Int = 0
    public var totalToSend: Int = 0
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try totalCustomer        <- decoder["total_customer"]
        try totalSended          <- decoder["total_sended"]
        try totalSendNotSuccess  <- decoder["total_send_not_success"]
        try totalToSend          <- decoder["total_to_send"]
    }
}

public struct TotalOrderProduct: Codable, Hashable  {
    
    public var productId: Int?
    public var productName: Int?
    public var qty: Int?
    public var productImg: String?
    public var product: Product?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try productId      <- decoder["product_id"]
        try productName    <- decoder["product_name"]
        try qty             <- decoder["qty"]
        try productImg     <- decoder["product_img"]
        try product         <- decoder["product"]
    }
}

public struct EmployeeWork: Codable, Hashable  {
    
    public var planName: String?
    public var empName: String?
    public var truckRegistrationNumber: String?
    public var productImg: String?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try planName                <- decoder["plan_name"]
        try empName                 <- decoder["emp_name"]
        try truckRegistrationNumber <- decoder["truck_registration_number"]
        try productImg              <- decoder["product_img"]
    }
}
