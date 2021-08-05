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
    case TMSCustomer
    case TMSTruck
    case TMSShipmentStock
    case TMSFeedback
    case TMSCreditPayment
}

extension DomainNameConfig {

    
    public var urlString: String {
        
        let HostURL = "http://185.78.165.78:3010"
        
        switch self {
        case .TMSDashboard:
            return "\(HostURL)/dashboard"
        case .TMSShipment:
            return "\(HostURL)/shipment"
        case .TMSOrder:
            return "\(HostURL)/orders"
        case .TMSTypeUser:
            return "\(HostURL)/type-user"
        case .TMSProductSpecialForTypeUser:
            return "\(HostURL)/product-special-for-type-user"
        case .TMSProductType:
            return "\(HostURL)/product-type"
        case .TMSProduct:
            return "\(HostURL)/products"
        case .TMSProductForTypeUser:
            return "\(HostURL)/product-for-type-user"
        case .TMSAssets:
            return "\(HostURL)/assets"
        case .TMSAssetStock:
            return "\(HostURL)/asset-stock"
        case .TMSAssetPickupStock:
            return "\(HostURL)/asset-pickup-stock"
        case .TMSCollectible:
            return "\(HostURL)/collectibles"
        case .TMSAuthEmployee:
            return "\(HostURL)/auth"
        case .TMSEmployee:
            return "\(HostURL)/employee"
        case .TMSJobPosition:
            return "\(HostURL)/jobposition"
        case .TMSTruck:
            return "\(HostURL)/truck"
        case .TMSPlanMaster:
            return "\(HostURL)/plan-master"
        case .TMSCustomer:
            return "\(HostURL)/customer"
        case .TMSShipmentStock:
            return "\(HostURL)/shipment-stock"
        case .TMSFeedback:
            return "\(HostURL)/feedback"
        case .TMSCreditPayment:
            return "\(HostURL)/credit-payment"
        case .TMSImagePath:
            return "\(HostURL)/" //+ path image url
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
