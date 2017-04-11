//
//  GameViewModel.swift
//  DYTV
//
//  Created by hegaokun on 2017/4/10.
//  Copyright © 2017年 AAS. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games: [GameModel] = [GameModel]()
}

extension GameViewModel {
    //请求游戏数据
    func loadAllGameData(finishedCallback: @escaping () -> ()) {
        //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            for dict in dataArray {
               self.games.append(GameModel(dict: dict))
            }
            finishedCallback()
        }
    }
}
