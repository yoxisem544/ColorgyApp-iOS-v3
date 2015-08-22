//
//  CourseDataBase.swift
//  ColorgyAPIHandler
//
//  Created by David on 2015/8/22.
//  Copyright (c) 2015年 David. All rights reserved.
//

import Foundation
import CoreData

class CourseDB {
    
    // delete all
    static func deleteAllCourses() {
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            let fetchRequest = NSFetchRequest(entityName: "Course")
            var e: NSError?
            var coursesInDB: [CourseDBManagedObject] = managedObjectContext.executeFetchRequest(fetchRequest, error: &e) as! [CourseDBManagedObject]
            if e != nil {
                println(ColorgyErrorType.DBFailure.fetchFail)
            } else {
                // nothing wrong
                for courseObject in coursesInDB {
                    managedObjectContext.deleteObject(courseObject)
                }
                managedObjectContext.save(&e)
                if e != nil {
                    println(ColorgyErrorType.DBFailure.saveFail)
                }
            }
        }
    }
    // delete specific course using code: String
    func deleteCourseWithCourseCode(code: String) {
        
    }
    // store course with a object??? maybe call this a courseRawData
    
    // get out all courses
    static func getAllCourses() {
        // TODO: we dont want to take care of dirty things, so i think i need to have a course class to handle this.
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            let fetchRequest = NSFetchRequest(entityName: "Course")
            var e: NSError?
            var coursesInDB: [CourseDBManagedObject] = managedObjectContext.executeFetchRequest(fetchRequest, error: &e) as! [CourseDBManagedObject]
            if e != nil {
                println(ColorgyErrorType.DBFailure.fetchFail)
            } else {
                for c in coursesInDB {
                    println(c)
                }
            }
        }
    }
    
    // fake data
    static func storeFakeData() {
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            var courseObject = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: managedObjectContext) as! CourseDBManagedObject
            // assign data
            courseObject.name = "自動化工程"
            courseObject.lecturer = "蔡明忠"
            courseObject.year = 2015
            courseObject.term = 1
            courseObject.uuid = "1041-AC5007701"
            courseObject.credits = 3
            
            // save
            var e: NSError?
            if managedObjectContext.save(&e) != true {
                println(ColorgyErrorType.DBFailure.saveFail)
            }
        }
    }
}