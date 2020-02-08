//
//  BaseCollectionViewCell.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
import UIKit
class BaseCollectionViewCell<T>: UICollectionViewCell {
    
    var mData:T? = nil {
        didSet{
            if let data = mData {
                self.bindData(data: data)
            }
        }
    }
    
    open func bindData(data:T){
        fatalError()
    }
    
}
