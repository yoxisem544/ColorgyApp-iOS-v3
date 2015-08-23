//
//  CourseRawDataArray.swift
//  ColorgyAPIHandler
//
//  Created by David on 2015/8/23.
//  Copyright (c) 2015年 David. All rights reserved.
//

import Foundation

class CourseRawDataArray {
    
    var courseRawDataArray: [CourseRawData]?
    
    init(json: JSON?) {
        if let json = json {
            // init raw data array
            self.courseRawDataArray = [CourseRawData]()
            if json.isArray {
                // an array of object
                for (index: String, json: JSON) in json {
                    // loop through all the array
                    if let courseRawData = CourseRawData(json: json) {
                        self.courseRawDataArray?.append(courseRawData)
                    }
                }
            } else {
                // only one object
                if let courseRawData = CourseRawData(json: json) {
                    self.courseRawDataArray?.append(courseRawData)
                }
            }
        }
    }
}

extension JSON {
    var isArray: Bool {
        for (k, v) in self {
            // will return 1 if this is a array
            if k == "1" {
                return true
            }
            break
        }
        return false
    }
}