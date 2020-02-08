//
//  DataRepository.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class DataRepository  {
    
    static let shared = DataRepository()
    let apiClient:Api = ApiClient.shared
    let db:RealmHelper = RealmHelper.shared
    let bag:DisposeBag = DisposeBag()
    
    func getAllWonder(error:BehaviorRelay<String?>) -> Observable<[WonderVO]>{
        
        if checkInternet() {
            
            apiClient
                .getAllWonders()
                .observeOn(MainScheduler.instance)
                .subscribeData(errorObs: error) { (dataResponse:WonderResponse) -> WonderResponse in
                    
                    _ = dataResponse.wonders.enumerated().map{ (index,element) in
                        element.id = index
                    }
                    
                    self.db.insertWonders(data: dataResponse.wonders) { (errorStr) in
                        
                        error.accept(errorStr)
                    }
                    
                    return dataResponse
                    
            }.disposed(by: bag)
            
        }
        
        return db.getAllWonders()
        
        
    }
    
    func deleteAllWonders() {
        
        db.deleteAllWonders()
        
    }
    
    func getWonderById(id:Int) -> WonderVO? {
        
        db.getWonderById(id: id)
    }
}
