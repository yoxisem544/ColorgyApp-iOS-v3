//
//  SwiftyJSONExtension.swift
//  ColorgyAPIHandler
//
//  Created by David on 2015/8/23.
//  Copyright (c) 2015年 David. All rights reserved.
//

import Foundation

extension JSON {
    var isArray: Bool {
        for (k, v) in self {
            // will return 1 if this is a array
            if k == "0" {
                return true
            }
            break
        }
        return false
    }
}