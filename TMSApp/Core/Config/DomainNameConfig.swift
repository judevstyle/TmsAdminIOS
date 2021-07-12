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
    case TMSAssetStock
    case TMSAssetPickupStock
    case TMSCollectible
    case TMSAuthEmployee
    case TMSEmployee
    case TMSJobPosition
    case TMSPlanMaster
    case TMSTruck
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
        case .TMSAssetStock:
            return "http://43.229.149.79:3010/asset-stock"
        case .TMSAssetPickupStock:
            return "http://43.229.149.79:3010/asset-pickup-stock"
        case .TMSCollectible:
            return "http://43.229.149.79:3010/collectibles"
        case .TMSAuthEmployee:
            return "http://43.229.149.79:3010/auth"
        case .TMSEmployee:
            return "http://43.229.149.79:3010/employee"
        case .TMSJobPosition:
            return "http://43.229.149.79:3010/jobposition"
        case .TMSTruck:
            return "http://43.229.149.79:3010/truck"
        case .TMSPlanMaster:
            return "http://43.229.149.79:3010/plan-master"
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
