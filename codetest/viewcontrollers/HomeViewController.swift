//
//  HomeViewController.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Kingfisher
class HomeViewController: BaseViewController {
    
    private var viewModel:HomeViewModel = HomeViewModel()
    let bag:DisposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var cvWonders: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        initDataObservations()
        viewModel.fetchData()
        
    }
    
    fileprivate func initCollectionView(){
        
        cvWonders.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(onForcedRefresh(_:)), for: .valueChanged)
        cvWonders.register(cell: WonderCollectionViewCell.self)
        if let layout = cvWonders.collectionViewLayout as? PintrestLayout {
            layout.delegate = self
        }
        
    }
    
    
    @objc private func onForcedRefresh(_ sender: Any) {
        
        viewModel.onForcedRefresh()
        
    }
    
    
    fileprivate func initDataObservations(){
        
        viewModel.wonderDataObs
            .observeOn(MainScheduler.instance)
            .bind(to: cvWonders.rx.items(cellIdentifier: String(describing: WonderCollectionViewCell.self), cellType: WonderCollectionViewCell.self)) {  (row,wonder,cell) in
                cell.mData = wonder
        }.disposed(by: bag)
        
        Observable
            .zip(
                cvWonders
                    .rx
                    .itemSelected
                ,cvWonders
                    .rx
                    .modelSelected(WonderVO.self)
        )
            .bind{ indexPath, model in
                
                self.viewModel.onClickWonder(data: model)
                
        }
        .disposed(by: bag)
        
        
        viewModel.isLoadingObs.bind(to: activityIndicator.rx.isAnimating,refreshControl.rx.isRefreshing).disposed(by: bag)
        
        viewModel
            .errorObs
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ error in
                
                if let error = error {
                    self.viewModel.isLoadingObs.accept(false)
                    self.showErrorMessage(msg: error)
                }
                
            }).disposed(by: bag)
        
        viewModel
            .detailsNavigeationEvent
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{data in
                
                if let data = data {
                    self.navigateToWonderDetails(data: data.id )
                }
                
            }).disposed(by: bag)
    }
}
extension HomeViewController : PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        
        if let imageSource = CGImageSourceCreateWithURL( URL(string:viewModel.mWonders[indexPath.item].image)! as CFURL, nil) {
            if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
                
                let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! Int
                return CGFloat((pixelHeight/2) + 30)
            }
        }
        
        return CGFloat(Int.random(in: 850...1000)/2)
    }
    
}
