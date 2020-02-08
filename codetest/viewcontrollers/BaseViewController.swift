//
//  BaseViewViewController.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    public let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initActivityIndicator()
        
        
    }
    
    fileprivate func initActivityIndicator() {
        activityIndicator.style = .medium
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.color = UIColor.white
        activityIndicator.stopAnimating()
        view.addSubview(activityIndicator)
    }
    

    func showErrorMessage(title:String = "Oops..." , msg:String){
        
         _ =  SweetAlert().showAlert(title, subTitle: msg, style: AlertStyle.error)
    }
    
}


