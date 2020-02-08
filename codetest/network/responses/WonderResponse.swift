//
//  WonderResponse.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
class WonderResponse: Codable {
    
    var wonders:[WonderVO] = []
    
    enum CodingKeys:String,CodingKey {
        case wonders
    }
}
