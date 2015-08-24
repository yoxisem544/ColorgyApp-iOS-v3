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
    
    // download whole bunch of courses data
    /// Get courses from server.
    ///
    /// :param: count: Pass the count you want to download. nil, 0, -1~ for all course.
    /// :returns: courseRawDataObjects: A parsed [CourseRawDataObject]? array. Might be nil or 0 element.
    class func getSchoolCourseData(count: Int?, completionHandler: (courseRawDataObjects: [CourseRawDataObject]?, json: JSON?) -> Void) {
        
        let afManager = AFHTTPSessionManager(baseURL: nil)
        afManager.requestSerializer = AFJSONRequestSerializer()
        afManager.responseSerializer = AFJSONResponseSerializer()
        
        if let organization = UserSetting.UserPossibleOrganization() {
            if let accesstoken = UserSetting.UserAccessToken() {
                let coursesCount = count ?? 20000
                let url = "https://colorgy.io:443/api/v1/" + organization.lowercaseString + "/courses.json?per_page=" + String(coursesCount)+"&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&access_token=" + accesstoken
                if url.isValidURLString {
                    afManager.GET(url, parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject) -> Void in
                        let json = JSON(response)
                        let courseRawDataArray = CourseRawDataArray(json: json)
                        completionHandler(courseRawDataObjects: courseRawDataArray.objects, json: json)
                        }, failure: { (task: NSURLSessionDataTask, error: NSError) -> Void in
                            println(ColorgyErrorType.APIFailure.failDownloadCourses)
                            completionHandler(courseRawDataObjects: nil, json: nil)
                    })
                } else {
                    println(ColorgyErrorType.invalidURLString)
                    completionHandler(courseRawDataObjects: nil, json: nil)
                }
            }
        } else {
            completionHandler(courseRawDataObjects: nil, json: nil)
            println(ColorgyErrorType.noOrganization)
        }
    }
    
    // course API
    // get course info
    /// Get a specific course raw data object using course code.
    /// Will just return a single data object.
    /// Not an array
    ///
    /// :param: code: A specific course code.
    /// :returns: courseRawDataObject: A single CourseRawDataObject?, might be nil.
    class func getCourseRawDataObjectWithCourseCode(code: String, completionHandler: (courseRawDataObject: CourseRawDataObject?) -> Void) {
        
        let afManager = AFHTTPSessionManager(baseURL: nil)
        afManager.requestSerializer = AFJSONRequestSerializer()
        afManager.responseSerializer = AFJSONResponseSerializer()
        
        if let accesstoken = UserSetting.UserAccessToken() {
            let url = "https://colorgy.io:443/api/v1/ntust/courses/" + code + ".json?access_token=" + accesstoken
            
            if url.isValidURLString {
                afManager.GET(url, parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject) -> Void in
                    println(response)
                    let json = JSON(response)
                    let object = CourseRawDataObject(json: json)
                    completionHandler(courseRawDataObject: object)
                    }, failure: { (task: NSURLSessionDataTask, error: NSError) -> Void in
                        println("Err \(error)")
                        completionHandler(courseRawDataObject: nil)
                })
            } else {
                println(ColorgyErrorType.invalidURLString)
                completionHandler(courseRawDataObject: nil)
            }
        } else {
            println(ColorgyErrorType.APIFailure.failGetUserCourses)
            completionHandler(courseRawDataObject: nil)
        }
    }
    
    // get students enrolled in specific course
    /// Get users who enroll in specific course.
    /// Server will return a UserCourseObject.
    ///
    /// :param: code: A course code.
    /// :returns: userCourseObjects: A [UserCourseObject]? array, might be nil.
    class func getStudentsInSpecificCourse(code: String, completionHandler: (userCourseObjects: [UserCourseObject]?) -> Void) {
        // server will return an array of user course objects json.
        let afManager = AFHTTPSessionManager(baseURL: nil)
        afManager.requestSerializer = AFJSONRequestSerializer()
        afManager.responseSerializer = AFJSONResponseSerializer()
        
        if let accesstoken = UserSetting.UserAccessToken() {
            let url = "https://colorgy.io:443/api/v1/user_courses.json?filter%5Bcourse_code%5D=" + code + "&&&&&&&&&access_token=" + accesstoken
            if url.isValidURLString {
                afManager.GET(url, parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject) -> Void in
                    let json = JSON(response)
                    let objects = UserCourseObjectArray(json: json).objects
                    completionHandler(userCourseObjects: objects)
                    }, failure: { (task: NSURLSessionDataTask, error: NSError) -> Void in
                        println(ColorgyErrorType.APIFailure.failGetUserCourses)
                        completionHandler(userCourseObjects: nil)
                })
            } else {
                println(ColorgyErrorType.invalidURLString)
                completionHandler(userCourseObjects: nil)
            }
        } else {
            println(ColorgyErrorType.APIFailure.failGetUserCourses)
            completionHandler(userCourseObjects: nil)
        }
    }
    
    // MARK: - User API
    // get me
    /// You can simply get Me API using this.
    /// 
    /// :returns: result: ColorgyAPIMeResult?, you can store it.
    /// :returns: error: An error if you got one, then handle it.
    class func me(completionHandler: (result: ColorgyAPIMeResult?, error: AnyObject?) -> Void) {
        
        let afManager = AFHTTPSessionManager(baseURL: nil)
        afManager.requestSerializer = AFJSONRequestSerializer()
        afManager.responseSerializer = AFJSONResponseSerializer()
        
        println("getting me API")
        
        if let accesstoken = UserSetting.UserAccessToken() {
            let url = "https://colorgy.io:443/api/v1/me.json?access_token=" + accesstoken
            
            if url.isValidURLString {
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
                println(ColorgyErrorType.invalidURLString)
                completionHandler(result: nil, error: ColorgyErrorType.invalidURLString)
            }
        } else {
            completionHandler(result: nil, error: ColorgyErrorType.noAccessToken)
        }
        
    }
    
    // get me courses
    /// Get self courses from server.
    ///
    /// :returns: userCourseObjects: A [UserCourseObject]? array, might be nil or 0 element.
    class func getMeCourses(completionHanlder: (userCourseObjects: [UserCourseObject]?) -> Void) {
        let ud = NSUserDefaults.standardUserDefaults()
        if let userId = UserSetting.UserId() {
            let userIdString = String(userId)
            ColorgyAPI.getUserCoursesWithUserId(userIdString, completionHandler: completionHanlder)
        } else {
            println(ColorgyErrorType.noSuchUser)
            completionHanlder(userCourseObjects: nil)
        }
    }
    // get other's courses
    /// Get a specific courses from server.
    ///
    /// If userid is not a Int string, then server will just return [ ] empty array.
    ///
    /// :param: userid: A specific user id
    /// :returns: userCourseObjects: A [UserCourseObject]? array, might be nil or 0 element.
    class func getUserCoursesWithUserId(userid: String, completionHandler: (userCourseObjects: [UserCourseObject]?) -> Void) {
        
        let afManager = AFHTTPSessionManager(baseURL: nil)
        afManager.requestSerializer = AFJSONRequestSerializer()
        afManager.responseSerializer = AFJSONResponseSerializer()
        
        let user = ColorgyUser()
        if let user = user {
            println("getting user \(userid)'s course")
            if let accesstoken = user.accessToken {
                let url = "https://colorgy.io:443/api/v1/user_courses.json?filter%5Buser_id%5D=" + userid + "&&&&&&&&&&access_token=" + accesstoken
                
                if url.isValidURLString {
                    afManager.GET(url, parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject) -> Void in
                        // will return a array of courses
                        let json = JSON(response)
                        let userCourseObjects = UserCourseObjectArray(json: json).objects
                        completionHandler(userCourseObjects: userCourseObjects)
                        }, failure: { (task: NSURLSessionDataTask, error: NSError) -> Void in
                            println(ColorgyErrorType.APIFailure.failGetUserCourses)
                            completionHandler(userCourseObjects: nil)
                    })
                } else {
                    println(ColorgyErrorType.invalidURLString)
                    completionHandler(userCourseObjects: nil)
                }
            } else {
                println(ColorgyErrorType.noAccessToken)
                completionHandler(userCourseObjects: nil)
            }
        } else {
            println(ColorgyErrorType.noSuchUser)
            completionHandler(userCourseObjects: nil)
        }
        
    }
    
    // PUT class
    // DELETE class
    // get user basic info
    // after get user basic info, do i need to download their image?
    // no, i'll download it if i need it
    
    
    
    // properties
    
    // functions
    
    // keys
//    struct Method {
//        static let put = "PUT"
//        static let delete = "DELETE"
//    }
    
}