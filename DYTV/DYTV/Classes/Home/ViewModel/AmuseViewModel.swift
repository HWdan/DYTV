//
//  AmuseViewModel.swift
//  DYTV
//
//  Created by hegaokun on 2017/4/11.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {
    
}

extension AmuseViewModel {
    
    func loadAmuseData(finishedCallback: @escaping () -> ()) {
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
