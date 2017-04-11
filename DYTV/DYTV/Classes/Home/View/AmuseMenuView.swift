//
//  AmuseMenuView.swift
//  DYTV
//
//  Created by hegaokun on 2017/4/11.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {
    //MARK:- 定义属性
    var groups: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    //MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    //MARK:- 从 xib 中加载出来执行
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    //MARK:- UI布局要在 layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }
}

//MARK:- 快速创建 AmuseMenuView
extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

//MARK:- UICollectionViewDataSource
extension AmuseMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {
            return 0
        }
        let pageNumber = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNumber
        return pageNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuViewCell
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func setupCellDataWithCell(cell: AmuseMenuViewCell, indexPath:IndexPath){
        //根据 0页：0 ~ 7  1页：8 ~ 15   2页：16 ~ 23 可以获取起点和终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        //越界处理
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        cell.groups = Array(groups![startIndex...endIndex])
    }
}

//MARK:- UICollectionViewDelegate
extension AmuseMenuView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}


