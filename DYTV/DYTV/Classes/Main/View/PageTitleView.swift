//
//  PageTitleView.swift
//  DYTV
//
//  Created by hegaokun on 2017/3/15.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

//MARK:- 设置代理
protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}

private let kScrollLineH: CGFloat = 2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {
    //MARK:- 定义属性
    var titles: [String]
    var currentIndex: Int = 0
    weak var delegate: PageTitleViewDelegate?
    
    //MARK:- 懒加载属性
    lazy var titlelabels: [UILabel] = [UILabel]()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //MARK:- 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 设置 UI
extension PageTitleView {
    func setupUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        //添加 title 对应的 label
        setupTitleLabels()
        //设置底线和滚动条
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels() {
        //label 的一些确定值
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            //设置 label 属性 
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            //设置 frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titlelabels.append(label)
            
            //添加 label 的手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelCilck(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        //获取第一个label
        guard let firstLabel = titlelabels.first else {return}
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        //添加 scrollline
        scrollView.addSubview(scrollLine)
      
    }
}

//MARK:- 监听 label 的点击
extension PageTitleView {
    @objc func titleLabelCilck(tapGes: UITapGestureRecognizer) {
        //获取当前 label 的下标值
        guard let currentLabel = tapGes.view as? UILabel else {return}
        //如果是重复点击同一个 title，那么直接返回
        if currentLabel.tag == currentIndex {return}
        //获取之前的里 label
        let oldLabel = titlelabels[currentIndex]
        //切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        //保存最新的 label 下标值
        currentIndex = currentLabel.tag
        //滚动条位置切换
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

//MARK:- 对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        //取出 sourceLabel targetLabel
        let sourceLabel = titlelabels[sourceIndex]
        let targetLabel = titlelabels[targetIndex]
        //处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        //取出颜色变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        //sourceLabel 颜色变化
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        //targetLabel 颜色变化
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        //记录最新的下标
        currentIndex = targetIndex
    }
}
