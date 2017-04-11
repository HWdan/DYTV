//
//  AmuseViewController.swift
//  DYTV
//
//  Created by hegaokun on 2017/4/11.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

private let kMenuViewH: CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    //MARK:- 懒加载
    fileprivate lazy var amuseVM: AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView: AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
}

//MARK:- 设置 UI
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(menuView)
        //设置内边距处理头部和最后部分显示不全的问题
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: kStausBarH + kNavigationBarH + kTitleViewH + kTabbarH, right: 0)
        
       
    }
}

//MARK:- 请求数据
extension AmuseViewController {
    override func loadData() {
        //给父类中 ViewModel 进行赋值
        baseVM = amuseVM
        amuseVM.loadAmuseData { 
            self.collectionView.reloadData()
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
        }
    }
}



