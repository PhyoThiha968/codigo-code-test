//
//  ViewEXTS.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    
    func register<T:UITableViewCell>(cell:T.Type){
        
        register(UINib(nibName: String(describing: cell.self), bundle: nil), forCellReuseIdentifier: String(describing: cell.self))
    }
    
    func deque<T:UITableViewCell>(indexPath:IndexPath) -> T{
        
        dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}

extension UICollectionView{
    
    func register<T:UICollectionViewCell>(cell:T.Type){
        
        register(UINib(nibName: String(describing:cell.self) , bundle: nil), forCellWithReuseIdentifier: String(describing:cell.self))
    }
    
    func deque<T:UICollectionViewCell>(indexPath:IndexPath) -> T {
        
        dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}

public typealias SimpleClosure = (() -> ())
private var tappableKey : UInt8 = 0
private var actionKey : UInt8 = 1

public extension UIView {
   
   @objc var viewOnClickListener: SimpleClosure {
       get {
           return objc_getAssociatedObject(self, &actionKey) as! SimpleClosure
       }
       set {
           objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
       }
   }
   
   var gesture: UITapGestureRecognizer {
       get {
           return UITapGestureRecognizer(target: self, action: #selector(tapped))
       }
   }
   
   var tappable: Bool! {
       get {
           return objc_getAssociatedObject(self, &tappableKey) as? Bool
       }
       set(newValue) {
           objc_setAssociatedObject(self, &tappableKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
           self.addTapGesture()
       }
   }
   
   fileprivate func addTapGesture() {
       if (self.tappable) {
           self.gesture.numberOfTapsRequired = 1
           self.isUserInteractionEnabled = true
           self.addGestureRecognizer(gesture)
       } else {
           self.isUserInteractionEnabled = false
       }
   }
   
   @objc private func tapped() {
       viewOnClickListener()
   }
}

extension NSObject: ScopeFunc { }


public protocol ScopeFunc {}
public extension ScopeFunc {
   @inline(__always) func apply(block: (Self) -> ()) -> Self {
       block(self)
       return self
   }
   @inline(__always) func with<R>(block: (Self) -> R) -> R {
       return block(self)
   }
}

public extension UITableView {
   
   //Variable-height UITableView tableHeaderView with autolayout
   func layoutTableHeaderView() {
       
       guard let headerView = self.tableHeaderView else { return }
       headerView.translatesAutoresizingMaskIntoConstraints = false
       
       let headerWidth = headerView.bounds.size.width;
       let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": headerWidth], views: ["headerView": headerView])
       
       headerView.addConstraints(temporaryWidthConstraints)
       
       headerView.setNeedsLayout()
       headerView.layoutIfNeeded()
       
       let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
       let height = headerSize.height
       var frame = headerView.frame
       
       frame.size.height = height
       headerView.frame = frame
       
       self.tableHeaderView = headerView
       
       headerView.removeConstraints(temporaryWidthConstraints)
       headerView.translatesAutoresizingMaskIntoConstraints = true
       
   }
}
