//
//  CustomNavigationController.swift
//  DYTV
//
//  Created by hegaokun on 2017/4/12.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //获取系统的 Pop 手势
        guard let systemGesture = interactivePopGestureRecognizer else {return}
        //获取手势添加到 View 中
        guard let gestureView = systemGesture.view else {return}
//        //使用运行时获取所有属性名称
//        var count:UInt32 = 0
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
//        for i in 0..<count {
//            let ivar = ivars[Int(i)]
//            let name = ivar_getName(ivar)
//            print(String(cString: name!))
//        }
        let targets = systemGesture.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else {return}
        //取出 target
        guard let target = targetObjc.value(forKey: "target") else {return}
        //取出 action
        let action = Selector(("handleNavigationTransition:"))
        //创建自己的 Pan 手势
        let panGesture = UIPanGestureRecognizer()
        gestureView.addGestureRecognizer(panGesture)
        panGesture.addTarget(target, action: action)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //隐藏要 push 的控制器的 tabbar
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}
