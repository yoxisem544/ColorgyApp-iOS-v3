//
//  ColorgyErrorType.swift
//  ColorgyAPIHandler
//
//  Created by David on 2015/8/22.
//  Copyright (c) 2015年 David. All rights reserved.
//

import Foundation

struct ColorgyErrorType {
    static let noSuchUser = "no user"
    static let noAccessToken = "no access token"
    static let failToLoginColorgy = "fail to login into colorgy"
    static let canceledFBLogin = "user cancel fb login"
    static let failToLoginFB = "user fail to login fb"
    // API failure
    struct APIFailure {
        static let failGetUserCourses = "fail to get specific user's courses"
    }
    struct DBFailure {
        static let deleteFail = "user fail to delete courses in db"
        static let saveFail = "user fail to save and make change to db"
        static let fetchFail = "user fetch data from db fail"
    }
}