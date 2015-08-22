//
//  File.swift
//  ColorgyAPIHandler
//
//  Created by David on 2015/8/22.
//  Copyright (c) 2015年 David. All rights reserved.
//

import Foundation

class Course {
    // properties
    // what do we need of a course?
    var code: String
    var name: String
    var year: Int
    var term: Int
    var lecturer: String?
    var credits: Int?
    var _type: String?
    // how to configure location period ?
    var days: [Int]?
    var periods: [Int]?
    var locations: [String]?
    
    
    init?(code: String?, name: String?, year: Int?, term: Int?, lecturer: String?, credits: Int?, _type: String?, days: [Int]?, periods: [Int]?, locations: [String]?) {
        // optional part
        self.days = days
        self.periods = periods
        self.locations = locations
        self._type = _type
        self.lecturer = lecturer
        self.credits = credits
        // required part
        self.code = ""
        self.name = ""
        self.year = Int()
        self.term = Int()
        if let code = code {
            self.code = code
        } else {
            return nil
        }
        if let name = name {
            self.name = name
        } else {
            return nil
        }
        if let year = year {
            self.year = year
        } else {
            return nil
        }
        if let term = term {
            self.term = term
        } else {
            return nil
        }
    }

    // dont know if always have data in to this init? considering....
//    convenience init?(courseObject: CourseDBManagedObject) {
//        
//    }
    
    // functions?
    
}