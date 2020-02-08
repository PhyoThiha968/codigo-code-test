//
//  HomeViewModel.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModel : BaseViewModel {
    
    let bag:DisposeBag = DisposeBag()
    var wonderDataObs:BehaviorRelay<[WonderVO]> = BehaviorRelay(value: [])
    var detailsNavigeationEvent:BehaviorRelay<WonderVO?> = BehaviorRelay(value: nil)
    
    var mWonders:[WonderVO] = []{
        didSet{
            self.wonderDataObs.accept(self.mWonders)
        }
    }
    
    func fetchData() {
        
        
        isLoadingObs.accept(true)
        
        dataRepository
            .getAllWonder(error: errorObs )
            .subscribe(onNext:{ data in
                
                self.mWonders = data
                if data.count > 0 {
                    self.isLoadingObs.accept(false)
                }
                
            },onError: { error in
                
                self.isLoadingObs.accept(false)
                
            }).disposed(by: bag)
        
    }
    
    func onForcedRefresh(){

        if checkInternet() {
            
            dataRepository.deleteAllWonders()
            fetchData()
            
        }else{
            
            errorObs.accept("No Internet")
        }
       
    }
    
    func onClickWonder(data:WonderVO){
        detailsNavigeationEvent.accept(data)
    }
    
}


