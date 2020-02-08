//
//  BaseViewModel.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class BaseViewModel {
    
    var isLoadingObs:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var errorObs:BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let dataRepository:DataRepository = DataRepository.shared
}
