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
    
    var isLoading:BehaviorRelay<Bool?> = BehaviorRelay(value: nil)
    var errorObs:BehaviorRelay<String?> = BehaviorRelay(value: nil)
}
