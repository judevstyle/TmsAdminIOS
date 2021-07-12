//
//  PostEmployeeRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/8/21.
//

import Foundation

public struct PostEmployeeRequest: Codable, Hashable {
    
    public var compId: Int?
    public var jobPositionId: Int?
    public var attachFiles: [AttachFilesImage]?
    public var empFname: String?
    public var empLname: String?
    public var empBirthday: String?
    public var empTel1: String?
    public var empAvatar: EmpAvatarImage?
    public var empEmail: String?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case compId = "comp_id"
        case jobPositionId = "job_position_id"
        case attachFiles = "attach_files"
        case empFname = "emp_fname"
        case empLname = "emp_lname"
        case empBirthday = "emp_birthday"
        case empTel1 = "emp_tel1"
        case empAvatar = "emp_avatar"
        case empEmail = "emp_email"
    }
}

public struct AttachFilesImage: Codable, Hashable {
    
    public var filePath: String?
    public var del: Int = 0

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
        case del = "del"
    }
    
    public init(from decoder: Decoder) throws {
        try filePath         <- decoder["file_path"]
        try del              <- decoder["del"]
    }
}

public struct EmpAvatarImage: Codable, Hashable {
    
    public var url: String?

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
    
    public init(from decoder: Decoder) throws {
        try url         <- decoder["url"]
    }
}
