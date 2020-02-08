//
//  WonderDetailViewController.swift
//  codetest
//
//  Created by Phyo Thiha on 08/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WonderDetailViewController: BaseViewController {
    
    var wonderID:Int = -1
    
    @IBOutlet weak var ivWonder: UIImageView!
    @IBOutlet weak var btnBack: UIImageView!{
        didSet{
            btnBack.tappable = true
        }
    }
    @IBOutlet weak var lblWonderDescription: UILabel!
    @IBOutlet weak var lblWonderName: UILabel!
    @IBOutlet weak var wonderDetailsTableView: UITableView!
    
    private var viewModel:WonderDetailsViewModel = WonderDetailsViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ivWonder.addGradient(start: UIColor.clear, end: UIColor.black)
        
        if wonderID != -1  {
            viewModel.getWonder(id: wonderID)
        }
        wonderDetailsTableView.tableFooterView = UIView()
        initListeners()
        initDataObservations()
        
    }
    
    fileprivate func initListeners(){
        
        btnBack.viewOnClickListener = {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func initDataObservations(){
        
        viewModel
            .errorObs
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                
                if let data = data {
                    
                    self.showErrorMessage(msg: data)
                }
                
            }).disposed(by: bag)
        
        viewModel.wonderDataObs
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                self.bindData(data: data)
            }).disposed(by: bag)
    }
    
    fileprivate func bindData(data:WonderVO?){
        
        if let data = data {
            ivWonder.loadImageWithUrl(url: data.image)
            lblWonderName.text = data.location
            lblWonderDescription.text = data.wonderDescription
        
            
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        wonderDetailsTableView.layoutTableHeaderView()
    }
}


