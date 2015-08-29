//
//  TimeTableView.swift
//  ColorgyAPIHandler
//
//  Created by David on 2015/8/28.
//  Copyright (c) 2015年 David. All rights reserved.
//

import UIKit

class TimeTableView: UIScrollView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    // private properties
    private let screenWidth: CGFloat
    
    private let sessionSideBarWidth: CGFloat = 37
    
    private let courseCellWidth: CGFloat
    private let courseCellSpacing: CGFloat = 2
    private let courseContainerWidth: CGFloat
    
    private let weekdayHeaderHeight: CGFloat = 35
    
    private var timetableContentScrollView: UIScrollView!
    private var weekdayHeaderScrollView: UIScrollView!
    
    // MARK: - initializer
    init() {
        // get screen width
        screenWidth = UIScreen.mainScreen().bounds.width
        // we have 4 spacings between 5 days.
        // so here we want to get cell size
        // first, delete side bar width and 4 spacings
        // then divide by 5, cause we want to see 5 cell a time
        courseCellWidth = (screenWidth - (4 * courseCellSpacing) - sessionSideBarWidth) / CGFloat(5)
        // this is width without spacing, more accurate for align
        courseContainerWidth = (screenWidth - sessionSideBarWidth) / CGFloat(5)
        
        // after all properties is inited
        super.init(frame: UIScreen.mainScreen().bounds)
        // configure self scroll view
        self.bounces = false
        self.backgroundColor = UIColor.lightGrayColor()
        
        // get count of period data
        var fakePeriods = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "A", "B", "C", "D"]
        
        // generate header view
        // 7 days a week
        var headerView = UIView(frame: CGRectMake(0, 0, courseContainerWidth * 7, weekdayHeaderHeight))
        for (index, day: String) in enumerate(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]) {
            var dayLabel = UILabel(frame: CGRectMake(0, 0, 60, 20))
            dayLabel.textAlignment = NSTextAlignment.Center
            dayLabel.text = day
            dayLabel.textColor = UIColor.blackColor()
            let baseOffset = courseContainerWidth / 2
            dayLabel.center.x = baseOffset + CGFloat(index) * courseContainerWidth
            dayLabel.center.y = headerView.bounds.midY
            headerView.addSubview(dayLabel)
        }
        weekdayHeaderScrollView = UIScrollView(frame: CGRectMake(0, 0, screenWidth - sessionSideBarWidth, weekdayHeaderHeight))
        weekdayHeaderScrollView.contentSize = CGSize(width: headerView.bounds.width, height: weekdayHeaderHeight)
        weekdayHeaderScrollView.addSubview(headerView)
        self.addSubview(weekdayHeaderScrollView)
        weekdayHeaderScrollView.frame.origin.x = sessionSideBarWidth
        
        // expand content size
        self.contentSize = UIScreen.mainScreen().bounds.size
        var h: CGFloat = CGFloat(fakePeriods.count) * courseContainerWidth + weekdayHeaderHeight
        self.contentSize.height = h
        
        // generate session side bar, uiview
        var sessionSideBarView = UIView(frame: CGRectMake(0, 0, sessionSideBarWidth, courseContainerWidth * CGFloat(fakePeriods.count)))
        for (index, period: String) in enumerate(fakePeriods) {
            var periodLabel = UILabel(frame: CGRectMake(0, 0, sessionSideBarWidth, courseContainerWidth))
            periodLabel.textColor = UIColor.blackColor()
            periodLabel.text = period
            periodLabel.textAlignment = NSTextAlignment.Center
            let baseOffset = courseContainerWidth / 2
            periodLabel.center.x = sessionSideBarView.bounds.midX
            periodLabel.center.y = baseOffset + CGFloat(index) * courseContainerWidth
            sessionSideBarView.addSubview(periodLabel)
        }
        self.addSubview(sessionSideBarView)
        sessionSideBarView.frame.origin.y = weekdayHeaderHeight
        
        // timetable content scroll view
        timetableContentScrollView = UIScrollView(frame: CGRectMake(0, 0, screenWidth - sessionSideBarWidth, sessionSideBarView.bounds.height))
        var w = headerView.bounds.width
        h = sessionSideBarView.bounds.height
        timetableContentScrollView.contentSize = CGSize(width: w, height: h)
        timetableContentScrollView.backgroundColor = UIColor.brownColor()
        timetableContentScrollView.frame.origin.x = sessionSideBarWidth
        timetableContentScrollView.frame.origin.y = weekdayHeaderHeight
        self.addSubview(timetableContentScrollView)
        timetableContentScrollView.delegate = self
        timetableContentScrollView.bounces = false
        var ball = UIView(frame: CGRectMake(300, 300, 30, 30))
        ball.backgroundColor = UIColor.greenColor()
        timetableContentScrollView.addSubview(ball)
        
        println(timetableContentScrollView.contentSize)
        println(self.contentSize)
        
        // generate timetable content view, scroll view
        
        
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TimeTableView: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.timetableContentScrollView {
            self.weekdayHeaderScrollView.contentOffset.x = self.timetableContentScrollView.contentOffset.x
        }
    }
}