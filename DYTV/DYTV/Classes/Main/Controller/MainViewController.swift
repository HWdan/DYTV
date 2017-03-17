//
//  MainViewController.swift
//  DYTV
//
//  Created by hegaokun on 2017/3/15.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
    }
    
    private func addChildVC(storyName: String) {
        //通过 storyboard 获取控制器
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        //将 childVC 作为子控制器
        addChildViewController(childVC)
    }
}
