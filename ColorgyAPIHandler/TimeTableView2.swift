//
//  TimeTableView2.swift
//  ColorgyAPIHandler
//
//  Created by David on 2015/8/29.
//  Copyright (c) 2015年 David. All rights reserved.
//

import UIKit

class TimeTableView2: UIView {

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
    private var sessionSideBarScrollView: UIScrollView!
    
    override init(frame: CGRect) {
        // get screen width
        screenWidth = UIScreen.mainScreen().bounds.width
        // we have 4 spacings between 5 days.
        // so here we want to get cell size
        // first, delete side bar width and 4 spacings
        // then divide by 5, cause we want to see 5 cell a time
        courseCellWidth = (screenWidth - (4 * courseCellSpacing) - sessionSideBarWidth) / CGFloat(5)
        // this is width without spacing, more accurate for align
        courseContainerWidth = (screenWidth - sessionSideBarWidth) / CGFloat(5)
        
        // init!
        super.init(frame: frame)
        
        var fakePeriods = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "A", "B", "C", "D"]
        
        // first configure session side bar view
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
        // after we generate content of session side bar scroll view, we are going to add it
        var w = sessionSideBarWidth
        // according to frame assigned
        var h = frame.height - weekdayHeaderHeight
        self.sessionSideBarScrollView = UIScrollView(frame: CGRectMake(0, 0,  w, h))
        self.sessionSideBarScrollView.contentSize = sessionSideBarView.bounds.size
        self.sessionSideBarScrollView.addSubview(sessionSideBarView)
        // also, we dont want user to move this
        self.sessionSideBarScrollView.scrollEnabled = false
        // configure
        self.sessionSideBarScrollView.backgroundColor = UIColor.lightGrayColor()
        
        // second configure header
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
        w = frame.width - sessionSideBarWidth
        h = weekdayHeaderHeight
        self.weekdayHeaderScrollView = UIScrollView(frame: CGRectMake(0, 0, w, h))
        self.weekdayHeaderScrollView.contentSize = headerView.bounds.size
        self.weekdayHeaderScrollView.addSubview(headerView)
        // also, we dont want user to move this
        self.weekdayHeaderScrollView.scrollEnabled = false
        // configure
        self.weekdayHeaderScrollView.backgroundColor = UIColor.lightGrayColor()
        
        // third configure timetable content
        w = self.weekdayHeaderScrollView.bounds.width
        h = self.sessionSideBarScrollView.bounds.height
        timetableContentScrollView = UIScrollView(frame: CGRectMake(0, 0, w, h))
        w = self.weekdayHeaderScrollView.contentSize.width
        h = self.sessionSideBarScrollView.contentSize.height
        timetableContentScrollView.contentSize = CGSize(width: w, height: h)
        timetableContentScrollView.backgroundColor = UIColor.brownColor()
        timetableContentScrollView.delegate = self
        timetableContentScrollView.bounces = false
        var ball = UIView(frame: CGRectMake(300, 300, 30, 30))
        ball.backgroundColor = UIColor.greenColor()
        timetableContentScrollView.addSubview(ball)
        
        // arrange view position
        timetableContentScrollView.frame.origin.x = sessionSideBarWidth
        timetableContentScrollView.frame.origin.y = weekdayHeaderHeight
        self.addSubview(timetableContentScrollView)
        
        weekdayHeaderScrollView.frame.origin.x = sessionSideBarWidth
        self.addSubview(weekdayHeaderScrollView)
        
        sessionSideBarScrollView.frame.origin.y = weekdayHeaderHeight
        self.addSubview(sessionSideBarScrollView)
        
        // add subviews to view itself
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TimeTableView2: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.timetableContentScrollView {
            self.weekdayHeaderScrollView.contentOffset.x = self.timetableContentScrollView.contentOffset.x
            self.sessionSideBarScrollView.contentOffset.y = self.timetableContentScrollView.contentOffset.y
        }
    }
}
