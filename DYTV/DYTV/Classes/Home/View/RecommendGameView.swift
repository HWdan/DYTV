//
//  RecommendGameView.swift
//  DYTV
//
//  Created by hegaokun on 2017/4/7.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin: CGFloat = 10

class RecommendGameView: UIView {
    //MARK:- 定义数据的属性
    var groups: [BaseGameModel]? {
        didSet {
            //刷新数据
            collectionview.reloadData()
        }
    }
    
    //MARK:- 控件属性
    @IBOutlet weak var collectionview: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //注册 cell
        collectionview.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        //设置 collectionview 的内边距
        collectionview.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}

//MARK:- 提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

//MARK:- 
extension RecommendGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.baseGame = groups?[indexPath.item]
        return cell
    }
}
