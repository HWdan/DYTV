//
//  CollectionBaseCell.swift
//  DYTV
//
//  Created by hegaokun on 2017/3/21.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    
    //MARK:- 定义模型属性
    var anchor:AnchorModel? {
        didSet {
            guard let anchor = anchor else {return}
            var onlineString: String = ""
            
            //取出在线人数显示的文字
            if anchor.online >= 10000 {
                onlineString = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineString = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineString, for: .normal)
            
            //昵称的显示
            nickNameLabel.text = anchor.nickname
            
            //设置封面图片
            guard let iconURL = NSURL(string: anchor.vertical_src) else {return}
            let resource = ImageResource(downloadURL: iconURL as URL)
            iconImageView.kf.setImage(with: resource)
        }
    }
}
