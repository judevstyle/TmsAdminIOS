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
    case TMSOrder
    case TMSTypeUser
    case TMSProductType
    case TMSProduct
    case TMSProductSpecialForTypeUser
    case TMSProductForTypeUser
    case TMSAssets
}

extension DomainNameConfig {
    public var urlString: String {
        switch self {
        case .TMSDashboard:
            return "http://43.229.149.79:3010/dashboard"
        case .TMSShipment:
            return "http://43.229.149.79:3010/shipment"
        case .TMSOrder:
            return "http://43.229.149.79:3010/orders"
        case .TMSTypeUser:
            return "http://43.229.149.79:3010/type-user"
        case .TMSProductSpecialForTypeUser:
            return "http://43.229.149.79:3010/product-special-for-type-user"
        case .TMSProductType:
            return "http://43.229.149.79:3010/product-type"
        case .TMSProduct:
            return "http://43.229.149.79:3010/products"
        case .TMSProductForTypeUser:
            return "http://43.229.149.79:3010/product-for-type-user"
        case .TMSAssets:
            return "http://43.229.149.79:3010/assets"
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
