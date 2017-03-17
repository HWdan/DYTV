//
//  UIBarButtonItem-Extension.swift
//  DYTV
//
//  Created by hegaokun on 2017/3/15.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //类方法
    /*class func createItem(normalImg: String,highlighted: String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: normalImg), for: .normal)
        btn.setImage(UIImage(named: highlighted), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    */
    
    //便利构造函数：1.以 convenience 开头 2.在构造函数中必须调用一个设计的构造函数(self)
    convenience init(normalImg: String,highlighted: String = "", size: CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: normalImg), for: .normal)
        if highlighted != "" {
            btn.setImage(UIImage(named: highlighted), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
}
