//
//  WonderDetailsViewModel.swift
//  codetest
//
//  Created by Phyo Thiha on 08/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class WonderDetailsViewModel: BaseViewModel {
    
    var wonderDataObs:BehaviorRelay<WonderVO?> = BehaviorRelay(value: nil)
    
    func getWonder(id:Int){
        
        let wonder = dataRepository.getWonderById(id: id)
        if let wonder = wonder {
            wonderDataObs.accept(wonder)
            
        }else{
            errorObs.accept("Wonder not found")
        }
    }
    
}
