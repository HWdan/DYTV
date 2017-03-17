//
//  PageContentView.swift
//  DYTV
//
//  Created by hegaokun on 2017/3/15.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

//MARK:- 设置代理
protocol PageContentViewDelegate: class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    //MARK:- 定义属性
    var childVcs: [UIViewController]
    weak var parentViewController: UIViewController?
    weak var delegate: PageContentViewDelegate?
    var startOffsetX: CGFloat = 0
    var isForbiScrollDelegate: Bool = false
    
    //MARK:- 懒加载属性
    lazy var collectionView: UICollectionView = {[weak self] in
        //创建 layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //创建 UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    //MARK:- 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 设置 UI
extension PageContentView {
    func setupUI() {
        //将所有的子控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        //添加 UICollectionView ，用于在 cell 中存放控制器的 View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK:- UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

//MARK:- UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbiScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否是点击事件
        if isForbiScrollDelegate { return }
        //获取需要的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        //判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {//左滑
            //计算滑动进度 progress
            let ratio = currentOffsetX / scrollViewW
            progress = ratio - floor(ratio)
            //计算 sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //计算 targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //如果完全滑动过去一个页面
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else {//右滑
            //计算滑动进度 progress
            let ratio = currentOffsetX / scrollViewW
            progress = 1 - (ratio - floor(ratio))
            //计算目标 targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            //计算源 sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        //将数据传递给 titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK:- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int) {
        //记录需要禁止执行代理方法
        isForbiScrollDelegate = true
        //滚动到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}



