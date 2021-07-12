//
//  GetPlanMasterResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/11/21.
//

import Foundation

public struct GetPlanMasterResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: PlanMasterData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct PlanMasterData: Codable, Hashable  {
    
    public var items: [PlanMasterItems]?
    public var meta: MetaObject?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try items    <- decoder["items"]
        try meta     <- decoder["meta"]
    }
}

public struct PlanMasterItems: Codable, Hashable  {
    
    public var planId: Int?
    public var compId: Int?
    public var truckId: String?
    public var planType: String?
    public var planName: String?
    public var planDesc: String?
    public var totalCustomerToSent: Int?
    public var empoyeeName: String?
    public var empoyeeImg: String?
    public var employees: [EmployeeItems]?
    public var planCustomer: [PlanCustomerItems]?
    public var daily: [DailyItems]?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try planId                 <- decoder["plan_id"]
        try truckId                <- decoder["truck_id"]
        try compId                 <- decoder["comp_id"]
        try planType               <- decoder["plan_type"]
        try planName               <- decoder["plan_name"]
        try planDesc               <- decoder["plan_desc"]
        try totalCustomerToSent    <- decoder["total_customer_to_sent"]
        try empoyeeName            <- decoder["empoyee_name"]
        try empoyeeImg             <- decoder["empoyee_img"]
        try employees              <- decoder["employees"]
        try planCustomer           <- decoder["planCustomer"]
        try daily                  <- decoder["daily"]
    }
}

public struct PlanCustomerItems: Codable, Hashable  {
    
    public var planCusId: Int?
    public var planId: Int?
    public var planCusSeq: Int?
    public var cusId: Int?
    public var customer: CustomerItems?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try planCusId     <- decoder["plan_cus_id"]
        try planId        <- decoder["plan_id"]
        try planCusSeq    <- decoder["plan_cus_seq"]
        try cusId         <- decoder["cus_id"]
        try customer      <- decoder["customer"]
    }
}

public struct DailyItems: Codable, Hashable  {
    
    public var dailyId: Int?
    public var dailyName: String?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try dailyId     <- decoder["daily_id"]
        try dailyName   <- decoder["daily_name"]
    }
}
