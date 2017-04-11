//
//  AmuseMenuViewCell.swift
//  DYTV
//
//  Created by hegaokun on 2017/4/11.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class AmuseMenuViewCell: UICollectionViewCell {
    //MARK:- 定义属性
    var groups: [AnchorGroup]? {
        didSet {
            collectionview.reloadData()
        }
    }
    //MARK:- 控件属性
    @IBOutlet weak var collectionview: UICollectionView!
    
    //MARK:- 从 xib 中加载后执行
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionview.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    //MARK:- UI 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionview.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: collectionview.bounds.width / 4, height: collectionview.bounds.height / 2)
    }
    
}

extension AmuseMenuViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.clipsToBounds = true
        cell.baseGame = groups![indexPath.item]
        return cell
    }
}
