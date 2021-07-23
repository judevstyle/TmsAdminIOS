//
//  PutShipmentResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/15/21.
//

import Foundation

public struct PutShipmentResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: ShipmentCustomerItems?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

//
//"statusCode": 200,
//"success": true,
//"data": {
//    "shipment_id": 51,
//    "plan_id": 15,
//    "plan_seq": 8,
//    "shipment_no": "S1150008",
//    "status": 1,
//    "create_by": null,
//    "create_date": "2021-06-19T08:34:00.935Z",
//    "update_by": "10003",
//    "update_date": "2021-06-19T08:34:00.935Z",
//    "shipmentCustomer": [
//        {
//            "shipment_cus_id": 257,
//            "shipment_id": 51,
//            "cus_id": 11,
//            "express": true,
//            "seq": 2,
//            "create_by": null,
//            "status_send": 1,
//            "status_send_remark": null,
//            "create_date": "2021-07-05T13:48:53.647Z",
//            "update_by": "10003",
//            "update_date": "2021-07-05T13:48:53.647Z"
//        },
//        {
//            "shipment_cus_id": 285,
//            "shipment_id": 51,
//            "cus_id": 8,
//            "express": false,
//            "seq": 3,
//            "create_by": "10003",
//            "status_send": 1,
//            "status_send_remark": null,
//            "create_date": "2021-07-14T17:24:14.777Z",
//            "update_by": "10003",
//            "update_date": "2021-07-14T17:24:14.777Z"
//        },
//        {
//            "shipment_cus_id": 314,
//            "shipment_id": 51,
//            "cus_id": 6,
//            "express": false,
//            "seq": 4,
//            "create_by": "10003",
//            "status_send": 1,
//            "status_send_remark": null,
//            "create_date": "2021-07-15T13:56:30.378Z",
//            "update_by": null,
//            "update_date": "2021-07-15T13:56:30.378Z"
//        }
//    ],
//    "shipmentStock": [
//        {
//            "shipment_stock_id": 66,
//            "shipment_id": 51,
//            "product_id": 24,
//            "qty": 60,
//            "mark": 0,
//            "status": "R",
//            "create_by": null,
//            "create_date": "2021-07-05T16:38:29.662Z",
//            "update_by": null,
//            "update_date": "2021-07-05T16:38:29.662Z"
//        },
//        {
//            "shipment_stock_id": 67,
//            "shipment_id": 51,
//            "product_id": 15,
//            "qty": 10,
//            "mark": 0,
//            "status": "R",
//            "create_by": null,
//            "create_date": "2021-07-05T16:38:29.662Z",
//            "update_by": null,
//            "update_date": "2021-07-05T16:38:29.662Z"
//        },
//        {
//            "shipment_stock_id": 68,
//            "shipment_id": 51,
//            "product_id": 14,
//            "qty": 15,
//            "mark": 0,
//            "status": "R",
//            "create_by": null,
//            "create_date": "2021-07-05T16:38:29.662Z",
//            "update_by": null,
//            "update_date": "2021-07-05T16:38:29.662Z"
//        }
//    ],
//    "planMaster": {
//        "plan_id": 15,
//        "comp_id": 1,
//        "truck_id": "T10004",
//        "plan_type": "N",
//        "plan_name": "แผนเดินรถ เสาร์-อาทิตย์ เส้น 003",
//        "plan_desc": "",
//        "create_by": null,
//        "create_date": "2021-05-23T16:35:08.702Z",
//        "update_by": null,
//        "update_date": "2021-05-23T16:35:08.702Z"
//    }
//}
//}
