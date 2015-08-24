//
//  ViewController.swift
//  ColorgyAPIHandler
//
//  Created by David on 2015/8/22.
//  Copyright (c) 2015年 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var accesstokenTextField: UITextField!
    @IBAction func updateAccesstokenClicked(sender: AnyObject) {
        println(self.user?.accessToken)
    }
    
    @IBOutlet weak var fbAccessTokenTextField: UITextField!
    @IBAction func LoginToFacebook(sender: UIButton) {
        var login = ColorgyLogin()
        ColorgyLogin.loginToFacebook { (token) -> Void in
            if let token = token {
                self.fbAccessTokenTextField.text = token
                ColorgyLogin.loginToColorgyWithToken(token, handler: { (response, error) -> Void in
                    if error != nil {
                        println("something wrong")
                    } else {
                        println("login ok, this is response body: \(response)")
                        if let res = response {
                            self.accesstoken = res.access_token
                            UserSetting.storeLoginResult(result: res)
                        }
                    }
                })
            }
        }
    }
    
    @IBOutlet weak var colorgyAccessTokenTextField: UITextField!
    var accesstoken: String? {
        didSet {
            println("at did set")
            println(accesstoken)
            self.colorgyAccessTokenTextField.text = accesstoken
        }
    }
    
    
    @IBAction func GetMeAPI(sender: AnyObject) {
        ColorgyAPI.me { (result, error) -> Void in
            if error != nil {
                println("error \(error)")
            } else {
                if let result = result {
                    UserSetting.storeAPIMeResult(result: result)
                    println("user now is \(ColorgyUser())")
                }
            }
        }
    }
    
    @IBOutlet weak var getuseridtextfield: UITextField!
    @IBAction func getusercourses(sender: AnyObject) {
        if let id = self.getuseridtextfield.text {
            ColorgyAPI.getUserCoursesWithUserId(id, comletionHandler: { (userCourseObjects) -> Void in
                println("okgetcourse")

                if let a = userCourseObjects {
                    for aa in a {
                        println(aa)
                    }
                }
            })
        }
    }
    @IBAction func getselfcourses(sender: AnyObject) {
        ColorgyAPI.getMeCourses { (userCourseObjects) -> Void in
            println("幹幹幹")
            println(userCourseObjects)
        }
    }
    @IBAction func downloadcoursescli(sender: AnyObject) {
        if let counts = self.coursecounttextfield.text.toInt() {
            ColorgyAPI.getSchoolCourseData(counts, completionHandler: { (courseRawDataObjects) -> Void in
                if let rawdataobjects = courseRawDataObjects {
                    for o in rawdataobjects {
                        println(o)
                    }
                }
            })
        }
        
    }
    @IBOutlet weak var coursecounttextfield: UITextField!
    let user = ColorgyUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println(self.user)
//        CourseDB.storeFakeData()
//        CourseDB.storeFakeData()
//        CourseDB.getAllStoredCoursesObject()
//        CourseDB.deleteCourseWithCourseCode("1041-AC5007701")
        ColorgyAPI.getStudentsInSpecificCourse("1041-AC5007701", completionHandler: { (userCourseObjects) -> Void in
            if let objs = userCourseObjects {
                println("\(objs.count) people enrolled in this course")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

