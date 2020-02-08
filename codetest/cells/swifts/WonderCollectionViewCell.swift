//
//  WonderCollectionViewCell.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import UIKit

class WonderCollectionViewCell: BaseCollectionViewCell<WonderVO> {
    
    @IBOutlet weak var ivWonder:UIImageView!
    @IBOutlet weak var lblWonderName:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func bindData(data: WonderVO) {
        
        lblWonderName.text = data.location
        ivWonder.loadImageWithUrl(url: data.image)
    }

}
