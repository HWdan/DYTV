//
//  AnchorModel.swift
//  DYTV
//
//  Created by hegaokun on 2017/3/20.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //房间 ID
    var room_id: Int = 0
    //房间图片对应的 URL
    var vertical_src: String = ""
    //0：电脑直播  1：手机直播
    var isVertical: Int = 0
    //房间名称
    var room_name: String  = ""
    //主播昵称
    var nickname: String = ""
    //观看人数
    var online: Int = 0
    //所在城市
    var anchor_city: String = ""
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
