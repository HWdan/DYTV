//
//  BaseViewController.swift
//  DYTV
//
//  Created by hegaokun on 2017/4/12.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    //MARK:- 定义属性
    var contentView: UIView?
    
    //MARK:- 懒加载
    fileprivate lazy var animImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.center.y = (kStausBarH + kNavigationBarH + kTitleViewH + kTabbarH) * 1.7
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        return imageView
    }()
    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
}

//MARK:- 设置 UI
extension BaseViewController {
    func setupUI() {
        //隐藏内容的 View
        contentView?.isHidden = true
        view.addSubview(animImageView)
        animImageView.startAnimating()
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDtaaFinished() {
        animImageView.stopAnimating()
        animImageView.isHidden = true
        contentView?.isHidden = false
    }
    
}
