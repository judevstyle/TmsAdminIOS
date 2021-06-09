//
//  SocketManager.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/4/21.
//

import Foundation
import UIKit
import SocketIO

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    
    let socket = SocketManager(socketURL: URL(string: "http://43.229.149.79:3010")!, config: [.log(true), .compress]).defaultSocket
    
    override init() {
        super.init()
    }
    
    
    func establishConnection() {
        socket.connect()
        print("Socket Connet")
    }
    
    
    func closeConnection() {
        socket.disconnect()
        print("Socket Disconnet")
    }
    
    func connectToServer() {
        socket.on("dashboard-balance") {[weak self] data, ack in
            print("Nontawat \(data)")
            print("Nontawat \(ack)")
        }
    }
    
    func actionDashboard() {
    }
    
}
