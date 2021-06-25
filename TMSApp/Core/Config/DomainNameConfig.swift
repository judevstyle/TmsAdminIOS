//
//  DomainNameConfig.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 25/6/2564 BE.
//

import Foundation

public enum DomainNameConfig {
    case TMSDashboard
    case TMSShipment
    case TMSImagePath
}

extension DomainNameConfig {
    public var urlString: String {
        switch self {
        case .TMSDashboard:
            return "http://43.229.149.79:3010/dashboard"
        case .TMSShipment:
            return "http://43.229.149.79:3010/shipment"
        case .TMSImagePath:
            return "http://43.229.149.79:3010/" //+ path image url
        }
    }
    
    public var headerKey: String {
        switch self {
        default:
            return ""
        }
    }
    
    public var url: URL {
        return URL(string: self.urlString)!
    }
}
