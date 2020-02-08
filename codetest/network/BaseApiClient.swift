//
//  BaseApi.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class BaseApiClient {
    
    static let BASE_URL = getConfig()?.apiurl ?? ""
    
    func reuqestApi<T>(
        url:String,
        method:HTTPMethod,
        params:Parameters,
        headers:HTTPHeaders? = nil,
        value: T.Type,
        encoding: ParameterEncoding = URLEncoding.default
    ) -> Observable<T>  where T : Codable {
        

        return Observable<T>.create { (observer) -> Disposable in
            
            let request =  Alamofire.request( BaseApiClient.BASE_URL + url , method: method, parameters: params, encoding: encoding ,  headers : headers)
                .responseJSON{ response in
                    
                    switch response.result {
                        
                    case .success:
                        
                        if  200 ... 299 ~= response.response?.statusCode ?? 500   {
                            
                            if let data = response.data!.seralizeData(for: T.self) {
                                observer.onNext(data)
                                observer.onCompleted()
                            } else {
                                observer.onError(NSError(domain: ERROR_MSG_JSON_PARSE, code: 500, userInfo: nil))
                            }
                            
                        } else {
                            
                            let error = response.data!.seralizeData(for: ErrorResponse.self)
                            observer.onError(NSError(domain: error?.message ?? "", code: error?.code ?? 500, userInfo: nil))
                        }
                        
                    case .failure(let error):
                        
                        observer.onError(error)
                    }
            }
            
            return Disposables.create(with: {
                request.cancel()
            })
            
        }
        
    }
    
}
