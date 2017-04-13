//
//  FunnyViewModel.swift
//  DYTV
//
//  Created by hegaokun on 2017/4/12.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {
    //MARK:- 懒加载
    
}

extension FunnyViewModel {
    func loadFunnyData(finishedCallback: @escaping () -> ()) {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}
