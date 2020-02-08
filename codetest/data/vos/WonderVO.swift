//
//  WonderVO.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
import RealmSwift

class WonderVO: Object,Codable {
    
    @objc dynamic var id:Int = 0
    @objc dynamic var location:String = ""
    @objc dynamic var wonderDescription:String
    @objc dynamic var image:String
    @objc dynamic var lat:String
    @objc dynamic var long:String
    
    enum CodingKeys:String,CodingKey{
        
        case location,image,lat,long
        case wonderDescription = "description"
    }
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

