//
//  CollectionGameCell.swift
//  DYTV
//
//  Created by hegaokun on 2017/4/7.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- 定义模型属性
    var baseGame: BaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
            let iconUrl = NSURL(string: baseGame?.icon_url ?? "")!
            let resource = ImageResource(downloadURL: iconUrl as URL)
            iconImageView.kf.setImage(with: resource, placeholder: UIImage(named: "home_more_btn"))
        }
    }
}
