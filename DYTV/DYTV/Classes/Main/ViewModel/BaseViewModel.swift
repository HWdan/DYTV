//
//  BaseViewModel.swift
//  DYTV
//
//  Created by hegaokun on 2017/4/11.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(isGroupData: Bool, URLString: String, parameters: [String : Any]? = nil, finishedCallback: @escaping () -> ()){
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            //判断是否是分组数据
            if isGroupData {
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            } else {
                let group = AnchorGroup()
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }
            finishedCallback()
        }
    }
}
