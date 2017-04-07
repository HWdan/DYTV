//
//  NSDate-Extension.swift
//  DYTV
//
//  Created by hegaokun on 2017/3/20.
//  Copyright © 2017年 AAS. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let newDate = NSDate()
        let interval = newDate.timeIntervalSince1970
        return "\(interval)"
    }
}
