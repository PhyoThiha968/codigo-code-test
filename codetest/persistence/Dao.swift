//
//  Dao.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
import RxSwift
import RxRealm

protocol Dao {
    func insertWonders(data:[WonderVO],onError:@escaping((String)->Void))
    func getAllWonders() -> Observable<[WonderVO]>
    func getWonderById(id:Int) -> WonderVO?
    func deleteAllWonders()
}
