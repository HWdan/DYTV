//
//  CollectionCycleCell.swift
//  DYTV
//
//  Created by hegaokun on 2017/4/7.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- 定义属性
    var cycleModel: CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconUrl = NSURL(string: cycleModel?.pic_url ?? "")!
            let resource = ImageResource(downloadURL: iconUrl as URL)
            iconImageView.kf.setImage(with: resource)
        }
    }
}
