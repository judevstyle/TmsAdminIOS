//
//  ShipmentStockManager.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/18/21.
//

import Foundation

public class ShipmentStockManager {
    
    public static let shared: ShipmentStockManager = ShipmentStockManager()
    
    fileprivate var selectShipmentStock: PostShipmentStockRequest = PostShipmentStockRequest()
    
    public init() { }
    
    public func getListSelectShipmentStock() -> PostShipmentStockRequest {
        return self.selectShipmentStock
    }
    
    public func setListSelectShipmentStock(item: PostShipmentStockRequest) {
        self.selectShipmentStock = item
    }
}
