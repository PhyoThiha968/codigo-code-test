//
//  ConfigVO.swift
//  codetest
//
//  Created by Phyo Thiha on 08/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
struct Config:Codable {

    let config:ConfigVO?
}

struct ConfigVO: Codable {
    var apiurl:String
  
    enum CodingKeys:String,CodingKey {
        case apiurl
    }
}


