//
//  Extensions.swift
//  RandomCat
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

extension UIView {
    
    func makeCorner(of radius: CGFloat = 0) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    
    func roundedCorners(with radius: CGFloat = 0, topLeft: Bool = true, topRight: Bool = true, bottomLeft: Bool = true, bottomRight: Bool = true) {
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            self.clipsToBounds = true
            var corners = CACornerMask()
            if topLeft {
                corners.insert(.layerMinXMinYCorner)
            }
            if topRight {
                corners.insert(.layerMaxXMinYCorner)
            }
            if bottomLeft {
                corners.insert(.layerMinXMaxYCorner)
            }
            if bottomRight {
                corners.insert(.layerMaxXMaxYCorner)
            }
            self.layer.maskedCorners = corners
        } else {
            var corners: UIRectCorner = []
            if topLeft {
                corners.insert(.topLeft)
            }
            if topRight {
                corners.insert(.topRight)
            }
            if bottomLeft {
                corners.insert(.bottomLeft)
            }
            if bottomRight {
                corners.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
        
    }
    
    
    struct LockHolder {
        static var lockView: UIView? = nil
    }
    
    func lock() {
        if LockHolder.lockView == nil {
            let bgView = UIView(frame: self.bounds)
            bgView.backgroundColor = UIColor.black.withAlphaComponent(0.45)
            self.addSubview(bgView)
            let indicator = UIActivityIndicatorView(style: .white)
            indicator.center = bgView.center
            bgView.addSubview(indicator)
            indicator.startAnimating()
            LockHolder.lockView = bgView
        }
    }
    
    func unlock() {
        if let lockView = LockHolder.lockView {
            lockView.removeFromSuperview()
            LockHolder.lockView = nil
        }
    }
}

extension UIColor {
    convenience init(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ a: CGFloat = 1){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
