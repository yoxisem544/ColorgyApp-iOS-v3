//
//  UserCourseObject.swift
//  ColorgyAPIHandler
//
//  Created by David on 2015/8/23.
//  Copyright (c) 2015年 David. All rights reserved.
//

import Foundation

class UserCourseObject: Printable {
    // uuid here is not code, is server's
    var uuid: String
    var id: Int
    var course_organization_code: String?
    var course_code: String
    var user_id: Int
    var year: Int
    var term: Int
    var _type: String
    
    var description: String { return "{\n\tuuid: \(uuid)\n\tid: \(id)\n\tcourse_organization_code: \(course_organization_code)\n\tcourse_code: \(course_code)\n\tuser_id: \(user_id)\n\tyear: \(year)\n\tterm: \(term)\n\t_type: \(_type)\n}" }
    
    private struct UserCourseObjectKey {
        static let uuid = "uuid"
        static let id = "id"
        static let course_organization_code = "course_organization_code"
        static let course_code = "course_code"
        static let user_id = "user_id"
        static let year = "year"
        static let term = "term"
        static let _type = "_type"
    }
    
    init?(json: JSON?) {
        self.uuid = String()
        self.id = Int()
        self.course_code = String()
        self.user_id = Int()
        self.year = Int()
        self.term = Int()
        self._type = String()
        if let json = json {
            if let uuid = json[UserCourseObjectKey.uuid].string {
                self.uuid = uuid
            } else {
                return nil
            }
            if let id = json[UserCourseObjectKey.id].int {
                self.id = id
            } else {
                return nil
            }
            if let course_organization_code = json[UserCourseObjectKey.course_organization_code].string {
                self.course_organization_code = course_organization_code
            }
            if let course_code = json[UserCourseObjectKey.course_code].string {
                self.course_code = course_code
            } else {
                return nil
            }
            if let user_id = json[UserCourseObjectKey.user_id].int {
                self.user_id = user_id
            } else {
                return nil
            }
            if let year = json[UserCourseObjectKey.year].int {
                self.year = year
            } else {
                return nil
            }
            if let term = json[UserCourseObjectKey.term].int {
                self.term = term
            } else {
                return nil
            }
            if let _type = json[UserCourseObjectKey._type].string {
                self._type = _type
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}