//
//  ApiClient.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
import RxSwift

class ApiClient: BaseApiClient {
    
    static let shared = ApiClient()
    
    private override init() {}
}

extension ApiClient : Api {
    
    func getAllWonders() -> Observable<WonderResponse> {
        
       return self.reuqestApi(url: API_GET_ALL_WONDERS
            , method: .get
            , params: [:]
            , value: WonderResponse.self)
    }
    
    
}
