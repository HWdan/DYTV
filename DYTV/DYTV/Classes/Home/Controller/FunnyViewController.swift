//
//  FunnyViewController.swift
//  DYTV
//
//  Created by hegaokun on 2017/4/12.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

private let kTopMargin: CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    //MARK:- 懒加载
    fileprivate lazy var funnyVM: FunnyViewModel = FunnyViewModel()
}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: kStausBarH + kNavigationBarH + kTitleViewH + kTabbarH, right: 0)
    }
}

extension FunnyViewController {
    override func loadData() {
        baseVM = funnyVM
        funnyVM.loadFunnyData { 
            self.collectionView.reloadData()
            //数据请求完成，调用
            self.loadDtaaFinished()
        }
    }
}
