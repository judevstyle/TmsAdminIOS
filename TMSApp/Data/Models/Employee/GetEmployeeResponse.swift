//
//  GetEmployeeResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/7/21.
//

import Foundation

public struct GetEmployeeResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: EmployeeData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct EmployeeData: Codable, Hashable  {
    
    public var items: [EmployeeItems]?
    public var meta: MetaObject?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try items    <- decoder["items"]
        try meta     <- decoder["meta"]
    }
}

public struct EmployeeItems: Codable, Hashable  {
    
    public var empId: Int?
    public var compId: Int?
    public var token: String?
    public var jobPositionId: Int?
    public var username: String?
    public var password: String?
    public var empCode: String?
    public var empDisplayName: String?
    public var empFname: String?
    public var empLname: String?
    public var empBirthday: String?
    public var empTel1: String?
    public var empTel2: String?
    public var empAvatar: String?
    public var empEmail: String?
    public var attachFiles: [AttachFilesImage]?
    public var company: CompanyItems?
    public var jobPosition: JobPositionItems?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try empId           <- decoder["emp_id"]
        try compId          <- decoder["comp_id"]
        try token           <- decoder["token"]
        try jobPositionId   <- decoder["job_position_id"]
        try username        <- decoder["username"]
        try password        <- decoder["password"]
        try empCode         <- decoder["emp_code"]
        try empDisplayName  <- decoder["emp_displayname"]
        try empFname        <- decoder["emp_fname"]
        try empLname        <- decoder["emp_lname"]
        try empBirthday     <- decoder["emp_birthday"]
        try empTel1         <- decoder["emp_tel1"]
        try empTel2         <- decoder["emp_tel2"]
        try empAvatar       <- decoder["emp_avatar"]
        try empEmail        <- decoder["emp_email"]
        try attachFiles     <- decoder["attach_files"]
        try company         <- decoder["company"]
        try jobPosition     <- decoder["job_position"]
    }
}

public struct CompanyItems: Codable, Hashable  {
    
    public var compId: Int?
    public var compName: String?
    public var compDesc: String?

    public init() {}
    
    public init(from decoder: Decoder) throws {
        try compId          <- decoder["comp_id"]
        try compName        <- decoder["comp_name"]
        try compDesc        <- decoder["comp_desc"]
    }
}
