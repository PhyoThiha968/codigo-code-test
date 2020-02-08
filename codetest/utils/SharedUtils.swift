//
//  SharedUtils.swift
//  codetest
//
//  Created by Phyo Thiha on 08/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import RealmSwift
import Realm
import Alamofire


func getConfig() -> ConfigVO?{
    if  let path        = Bundle.main.path(forResource: "Info", ofType: "plist"),
        let xml         = FileManager.default.contents(atPath: path),
        let config = try? PropertyListDecoder().decode(Config.self, from: xml)
    {
      
        return config.config
    }
    
    return nil
}


func checkInternet() -> Bool{
    
      return NetworkReachabilityManager()?.isReachable ?? false
    
    
}

