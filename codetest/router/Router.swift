//
//  Router.swift
//  codetest
//
//  Created by Phyo Thiha on 08/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
import UIKit

let SB_ID_WONDER_DETAILS = "SB_ID_WONDER_DETAILS"

extension UIStoryboard{
    
    static func getMainStoryBoard() -> UIStoryboard{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard
    }
}

extension UIViewController{
    
    func navigateToWonderDetails(data:Int){
        let storyBoard = UIStoryboard.getMainStoryBoard()
        let vc = storyBoard.instantiateViewController(withIdentifier: SB_ID_WONDER_DETAILS) as! WonderDetailViewController
        vc.wonderID = data
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
