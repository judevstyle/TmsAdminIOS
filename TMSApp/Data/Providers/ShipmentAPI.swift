//
//  ShipmentAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 25/6/2564 BE.
//

import Foundation
import Moya
import UIKit

public enum ShipmentAPI {
    case getShipment(request: GetShipmentRequest)
    case getShipmentWorking(request: GetShipmentWorkingRequest)
    case getShipmentCustomer(shipmentId: String)
}

extension ShipmentAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getShipment(_), .getShipmentWorking(_), .getShipmentCustomer(_):
            return DomainNameConfig.TMSShipment.url
        }
    }
    
    public var path: String {
        switch self {
        case .getShipment(_):
            return ""
        case .getShipmentWorking(_):
            return "shipmentWorking"
        case .getShipmentCustomer(let shipmentId):
            return "shipmentCustomer/\(shipmentId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getShipment(_), .getShipmentWorking(_), .getShipmentCustomer(_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getShipment(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case let .getShipmentWorking(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case .getShipmentCustomer(_):
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getShipmentWorking(_):
            authenToken = ""
        default:
            authenToken = ""
        }
        
        if authenToken.isEmpty {
            return ["Content-Type": "application/json"]
        }
        
        return ["Authorization": authenToken,
            "Content-Type": "application/json"]
    }
}
