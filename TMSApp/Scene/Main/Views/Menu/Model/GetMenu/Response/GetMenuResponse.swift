//
//  GetMenuResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/17/21.
//

import Foundation
import UIKit

struct GetMenuResponse {
    var title: String?
    var image: String?
    var scene: NavigationOpeningSender?
    
    init(title: String?, image: String?, scene: NavigationOpeningSender? = nil) {
        self.title = title
        self.image = image
        self.scene = scene
    }
}
