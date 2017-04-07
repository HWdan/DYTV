//
//  RecommendViewModel.swift
//  DYTV
//
//  Created by hegaokun on 2017/3/20.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

class RecommendViewModel {
    //MARK:- 懒加载
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    lazy var prerryGroup: AnchorGroup = AnchorGroup()
    lazy var cycleModels: [CycleModel] = [CycleModel]()
}

//MARK:- 发送网络请求
extension RecommendViewModel {
    //请求推荐数据
    func requestData(finishCallback: @escaping () -> ()) {
        //定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        //创建 Group
        let dGroup = DispatchGroup()
        
        //请求第一部分推荐数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            self.resultData(result: result, tag_name: "热门", icon_name: "home_header_hot", isHotCate: false, dataGroup: self.bigDataGroup)
            dGroup.leave()
        }
        
        //请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            self.resultData(result: result, tag_name: "颜值", icon_name: "home_header_phone", isHotCate: false, dataGroup: self.prerryGroup)
            dGroup.leave()
        }
        
        //请求最后部分游戏数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            self.resultData(result: result,isHotCate: true, dataGroup: self.prerryGroup)
            dGroup.leave()
        }
        
        //所有的数据都请求到之后，进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prerryGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
    
    //请求无线轮播数据
    func requestCycleData(finishCallback: @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.471"]) { (result) in
            //获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else {return}
            //根据 data 的 key 获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            finishCallback()
        }
    }
}

extension RecommendViewModel {
    func resultData(result: Any, tag_name: String="", icon_name: String="", isHotCate: Bool, dataGroup: AnchorGroup) {
        //将 result 转成字典类型
        guard let resultDict = result as? [String : NSObject] else { return }
        //根据 data 键（key），获取数组
        guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
        
        if isHotCate == true {
            //遍历数组，获取字典，并将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
        } else {
            //设置 组属性
            dataGroup.tag_name = tag_name
            dataGroup.icon_name = icon_name
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                dataGroup.anchors.append(anchor)
            }
        }
    }
}
