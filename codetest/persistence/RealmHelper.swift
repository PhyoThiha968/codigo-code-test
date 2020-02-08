//
//  RealmHelper.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

class RealmHelper: BaseRealmHelper {
    
    static let shared = RealmHelper()
    
    override private init() {}
    
    fileprivate func realmSimpleInsertList<T:Object>(_ data: [T], _ onError: ((String) -> Void)) {
        do{
            
            
            try realm.write{
                realm.add(data,update:.modified)
            }
            
        }catch let ex {
            
            onError(ex.localizedDescription)
        }
    }
}

extension RealmHelper : Dao {
    
    func insertWonders(data: [WonderVO], onError: @escaping ((String) -> Void)) {
        
        realmSimpleInsertList(data, onError)
        
    }
    
    func getAllWonders2() -> [WonderVO] {
        
       return Array(realm.objects(WonderVO.self))
        
    }
    
    func getAllWonders() -> Observable<[WonderVO]> {
        
       return Observable.array(from: realm.objects(WonderVO.self))
        
    }
    
    func getWonderById(id:Int) -> WonderVO? {
        
        return  realm.objects(WonderVO.self).filter("id = %@", id).first
    }
    
    func deleteAllWonders() {
        
        do{
            
            try realm.write {
                realm.delete(realm.objects(WonderVO.self))
            }
            
        }catch let ex {
            debugPrint(ex.localizedDescription)
        }
        
        
    }
    
    
}

