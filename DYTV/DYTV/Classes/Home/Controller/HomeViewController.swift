//
//  HomeViewController.swift
//  DYTV
//
//  Created by hegaokun on 2017/3/15.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit
let kTitleViewH: CGFloat = 40
class HomeViewController: UIViewController {
    //MARK: - 懒加载属性
    fileprivate lazy var pageTitleView: PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStausBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView:PageContentView = {[weak self] in
        //内容的frame
        let contentH = kScreenH - kStausBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStausBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        //所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommenViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        for _ in 0..<1 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self as PageContentViewDelegate?
        return contentView
    }()
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - 设置UI
extension HomeViewController {
    func setupUI () {
        //不需要调整 UIScrollView 的内边距
        automaticallyAdjustsScrollViewInsets = false
        //设置导航栏
        setupNavigationBar()
        //添加 titleView
        view.addSubview(pageTitleView)
        //添加 pageContentView
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBar() {
        //设置左侧 item
        navigationItem.leftBarButtonItem = UIBarButtonItem(normalImg: "logo")
        //历史
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(normalImg: "image_my_history", highlighted: "Image_my_history_click", size: size)
        //搜索
        let searchItem = UIBarButtonItem(normalImg: "btn_search", highlighted: "btn_search_clicked", size: size)
        //二维码
        let qrcodeItem = UIBarButtonItem(normalImg: "Image_scan", highlighted: "Image_scan_click", size: size)
        //设置右侧 item
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}

//MARK: - PageTitleViewDelegate
extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK: - 
extension HomeViewController: PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

