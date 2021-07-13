//
//  PostPlanMasterRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/13/21.
//

import Foundation

public struct PostPlanMasterRequest: Codable, Hashable {
    
    public var compId: Int?
    public var truckId: String?
    public var planType: String?
    public var planName: String?
    public var planDesc: String?
    public var employees: [PlanMasterEmployeesRequest]?
    public var planCustomers: [PlanMasterPlanCustomersRequest]?
    public var planSpecialDay: [PlanMasterPlanSpecialDayRequest]?
    public var daily: [PlanMasterDailyRequest]?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case compId = "comp_id"
        case truckId = "truck_id"
        case planType = "plan_type"
        case planName = "plan_name"
        case planDesc = "plan_desc"
        case employees = "employees"
        case planCustomers = "planCustomers"
        case planSpecialDay = "planSpecialDay"
        case daily = "daily"
    }
}

public struct PlanMasterEmployeesRequest: Codable, Hashable {
    
    public var empId: Int?
    public var del: Int = 0
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case empId = "emp_id"
        case del = "del"
    }
}

public struct PlanMasterPlanCustomersRequest: Codable, Hashable {
    
    public var cusId: Int?
    public var planCusSeq: Int?
    public var del: Int = 0
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case cusId = "cus_id"
        case planCusSeq = "plan_cus_seq"
        case del = "del"
    }
}


public struct PlanMasterPlanSpecialDayRequest: Codable, Hashable {
    
    public var planSpcTitle: String?
    public var planSpcDate: String?
    public var del: Int = 0
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case planSpcTitle = "plan_spc_title"
        case planSpcDate = "plan_spc_date"
        case del = "del"
    }
}

public struct PlanMasterDailyRequest: Codable, Hashable {
    
    public var dailyId: Int?
    public var del: Int = 0
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case dailyId = "daily_id"
        case del = "del"
    }
}
