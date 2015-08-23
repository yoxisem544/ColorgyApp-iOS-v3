//
//  ColorgyAPIHandler.swift
//  ColorgyAPIHandler
//
//  Created by David on 2015/8/22.
//  Copyright (c) 2015年 David. All rights reserved.
//

import Foundation

class ColorgyAPI {
    
    // what do i need here?
    // need to 
    
    // course API
    // get course info
    // get course students
    
    // user API
    // get me
    class func me(completionHandler: (result: ColorgyAPIMeResult?, error: AnyObject?) -> Void) {
        
        let afManager = AFHTTPSessionManager(baseURL: nil)
        afManager.requestSerializer = AFJSONRequestSerializer()
        afManager.responseSerializer = AFJSONResponseSerializer()
        
        println("getting me API")
        
        let user = ColorgyUser()
        if let accesstoken = user?.accessToken {
            let url = "https://colorgy.io:443/api/v1/me.json?access_token=" + accesstoken
            
            afManager.GET(url, parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject) -> Void in
                println("me API successfully get")
                // will pass in a json, then generate a result
                let json = JSON(response)
                println("ME get!")
                let result = ColorgyAPIMeResult(json: json)
                completionHandler(result: result, error: nil)
                }, failure: { (task: NSURLSessionDataTask, error: NSError) -> Void in
                    println("fail to get me API")
                    completionHandler(result: nil, error: "fail to get me API")
            })
        } else {
            completionHandler(result: nil, error: ColorgyErrorType.noAccessToken)
        }
        
    }
    // get me courses
    class func getMeCourses() {
        
    }
    // get other's courses
    // TODO: make a completion handler.
    class func getUserCoursesWithId(userid: String) {
        
        let afManager = AFHTTPSessionManager(baseURL: nil)
        afManager.requestSerializer = AFJSONRequestSerializer()
        afManager.responseSerializer = AFJSONResponseSerializer()
        
        let user = ColorgyUser()
        if let user = user {
            println("getting user \(userid)'s course")
            if let accesstoken = user.accessToken {
                let url = "https://colorgy.io:443/api/v1/user_courses.json?filter%5Buser_id%5D=" + userid + "&&&&&&&&&&access_token=" + accesstoken
                
                afManager.GET(url, parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject) -> Void in
                    // will return a array of courses
                    let json = JSON(response)
                    for (key, value) in json {
                        println("key \(key), \(value)")
                    }
                    }, failure: { (task: NSURLSessionDataTask, error: NSError) -> Void in
                        println(ColorgyErrorType.APIFailure.failGetUserCourses)
                })
            } else {
                println(ColorgyErrorType.noAccessToken)
            }
        } else {
            println(ColorgyErrorType.noSuchUser)
        }
        
    }
    // PUT class
    // DELETE class
    // get user basic info
    // after get user basic info, do i need to download their image?
    
    
    
    // properties
    
    // functions
    
    // keys
    struct Method {
        static let put = "PUT"
        static let delete = "DELETE"
    }
    
}