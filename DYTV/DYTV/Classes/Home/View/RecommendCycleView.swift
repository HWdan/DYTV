//
//  RecommendCycleView.swift
//  DYTV
//
//  Created by hegaokun on 2017/4/6.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    //MARK:- 定义属性
    var cycleTimer: Timer?
    
    var cycleModels: [CycleModel]? {
        didSet {
            //刷新表格 collectionview
            collectionview.reloadData()
            //设置 pageControl 个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            //设置默认滚动到中间的某个位置(处理一开始就往左边滚动)
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionview.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            //添加定时器（先移除在添加，防止出现问题）
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    //MARK:- 控件属性
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        //注册 cell
        collectionview.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置 collectionview 的 layout
        let layout = collectionview.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionview.bounds.size
    }
}

//MARK:- 提供创建 View 的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//MARK:- UICollectionViewDataSource
extension RecommendCycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        return cell
    }
}

//MARK:- UICollectionViewDelegate
extension RecommendCycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        //计算 pageControl 的 currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    //当用户开始拖拽时，先移除定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    //当用户停止拖拽时，添加定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

//MARK:- 对定时器的操作方法
extension RecommendCycleView {
    func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(RecommendCycleView.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    func removeCycleTimer() {
        //在运行循环中移除
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext() {
        //获取滚动的偏移量
        let currentOffsetX = collectionview.contentOffset.x
        let offsetX = currentOffsetX + collectionview.bounds.width
        //滚动该位置
        collectionview.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

