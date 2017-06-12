//
//  NSDate+Extensions.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 17/02/2017.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

extension Date {
    
    var usDateFormat: String {
        get {
            return DateFormatter.dateFormat(fromTemplate: "MMddyyyy", options: 0, locale: Locale(identifier: "en-US"))!
        }
    }
    //usDateFormat now contains an optional string "MM/dd/yyyy"
    
    var gbDateFormat: String {
        get {
            return DateFormatter.dateFormat(fromTemplate: "MMddyyyy", options: 0, locale: Locale(identifier: "en-GB"))!
            //gbDateFormat now contains an optional string "dd/MM/yyyy"
        }
    }
    
    var geDateFormat: String {
        get {
            return DateFormatter.dateFormat(fromTemplate: "MMddyyyy", options: 0, locale: Locale(identifier: "de-DE"))!
            //geDateFormat now contains an optional string "dd.MM.yyyy"
        }
    }
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self.inLocalTime)
    }
    
    var nextDay: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var previousDay: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    var startTimeOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endTimeOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    var dayNumberOfWeek: Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    var weekNumberOfYear: Int? {
        return Calendar.current.component(.weekOfYear, from: self)
    }
    
    // get weekday of the string
    var weekday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    var dayNumberString: String {
        
        return String(describing: Calendar.current.dateComponents([.day], from: self).day!)
    }
    
    var monthFirstDay: Date {
        let components = Calendar.current.dateComponents([.year,.month], from: self)
        return Calendar.current.date(from: components)!.adjustDayLightSavings
    }
    
    var monthLastDay: Date {
        let components = Calendar.current.dateComponents([.year,.month], from: self)
 
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: Calendar.current.date(from: components)!)!.adjustDayLightSavings
    }
    
    // get same day of previous month
    var previousMonth: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)!.adjustDayLightSavings
    }
    
    var currentMonthName: String {
        let monthComponents = Calendar.current.monthSymbols
        let comp = (Calendar.current as NSCalendar).components([.month], from: self)
        return monthComponents[comp.month!-1] // month components index starts with 0 while normal date starts with month 01. So deduct 1 from the index
    }
    
    var currentMonthIndex: Int {
        let comp = (Calendar.current as NSCalendar).components([.month], from: self)
        return comp.month!
    }
    
    // get same day of next month
    var nextMonth: Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)!.adjustDayLightSavings
    }
    
    var previousYear: Date {
        return Calendar.current.date(byAdding: .year, value: -1, to: self)!.adjustDayLightSavings
    }
    
    var currentYear: Int {
        let comp = (Calendar.current as NSCalendar).components([.year], from: self)
        return comp.year!
    }
    
    var nextYear: Date {
        return Calendar.current.date(byAdding: .year, value: 1, to: self)!.adjustDayLightSavings
    }
    
    var firstDayOfYear: Date {
        let calendar = Calendar.current as NSCalendar
        var components = DateComponents()
        components.day = 1
        components.month = 1
        
        let nextFirstJanuar = calendar.nextDate(after: self, matching: components, options: .matchNextTime)!
        let thisFirstJanuar = calendar.nextDate(after: nextFirstJanuar, matching: components, options: [.matchNextTime, .searchBackwards])!
        
        return thisFirstJanuar.adjustDayLightSavings
    }
    
    var daysCountInCompleteYear: Int {
        let nextFirstJanuar = self.nextYear.firstDayOfYear
        let thisFirstJanuar = self.firstDayOfYear
        
        let daysDiff = (Calendar.current as NSCalendar).components([.day], from: thisFirstJanuar, to: nextFirstJanuar, options: [])
        
        return daysDiff.day!
    }
    
    var daysLapsedInCurrentYear: Int {
        let thisFirstJanuar = self.firstDayOfYear
        let daysLapsed = (Calendar.current as NSCalendar).components([.day], from: thisFirstJanuar, to: self, options: [])
        
        return daysLapsed.day!
    }
    
    // adjust daylight saving settings while default is only UTC/GMT
    var adjustDayLightSavings: Date {
        return self.addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: self)))
    }
    
    // get date in local time and zone
    var inLocalTime: Date {
        let timedifference = TimeInterval(NSTimeZone.system.secondsFromGMT(for: self as Date))
        return self.addingTimeInterval(timedifference)
    }
    
    // get date in UTC time zone
    var inUTCTimeZone: Date {
        
        let timedifference = -TimeInterval(NSTimeZone.default.secondsFromGMT(for: self as Date))
        return self.addingTimeInterval(timedifference)
    }
    
    var UTCTimeString: String {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let comp = calendar.dateComponents([.hour, .minute], from: self)
        let hour = comp.hour
        let minute = comp.minute
        return "\(String(format: "%02d", hour!)):\(String(format: "%02d", minute!))"
    }
    
    var LocalTimeString: String {
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: self)
        let hour = comp.hour
        let minute = comp.minute
        return "\(String(format: "%02d", hour!)):\(String(format: "%02d", minute!))"
    }
    
    var readableDateString: String {
        get {
            let dayNumber = self.dayNumberString
            let monthName = self.currentMonthName
            let year = self.currentYear
            
            return "\(dayNumber). \(monthName) \(year)"
        }
    }
    
    static let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ"
        return formatter
    }()
    
    var flightBookSectionTitleString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = geDateFormat
        
        return formatter.string(from: self)
    }
    
    var iso8601: String {
        return Date.iso8601Formatter.string(from: self)
    }
    
    var dateComponentsInUTC: DateComponents {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        let date_comps = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return date_comps
    }
    
    // if target date is less that self then consider target date as tomorrow
    func hoursOffsetFromDate(targetDate: Date) -> String {
        if targetDate.compare(self) == .orderedAscending {
            let comps = (Calendar.current as NSCalendar).components([.hour,.minute], from: self, to: targetDate.nextDay, options: [])
            return "\(String(format: "%02d", comps.hour!)):\(String(format: "%02d", comps.minute!))"
        }
        let comps = (Calendar.current as NSCalendar).components([.hour,.minute], from: self, to: targetDate, options: [])
        return "\(String(format: "%02d", comps.hour!)):\(String(format: "%02d", comps.minute!))"
    }
    
    func timeStringAtHomeBase(_ homeBase: String) -> String {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let comp = calendar.dateComponents([.hour, .minute], from: self)
        let hour = comp.hour
        let minute = comp.minute
        return "\(String(format: "%02d", hour!)):\(String(format: "%02d", minute!))"
    }
    
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func daysOffsetFromDate(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.day, from: self, to: date, options: []).day!
    }
    
    func offsetStringFromDate(_ date:Date) -> String {
        
        let calendar = Calendar.current
        
        let dayHourMinuteSecond: NSCalendar.Unit = [.day, .hour, .minute, .second]
        let difference = (calendar as NSCalendar).components(dayHourMinuteSecond, from: date, to: self, options: [])
        
        if(date.isToday)
        {
            let seconds = "a few seconds ago"
            let minutes = difference.minute! > 1 ? "\(difference.minute!) minutes ago" : "\(difference.minute!) minute ago"
            let hours = difference.hour! > 1 ? "\(difference.hour!) hours ago" : "\(difference.hour!) hour ago"
            
            if difference.hour!   > 0 { return hours }
            if difference.minute! > 0 { return minutes }
            if difference.second! > 0 { return seconds }
        }
        
        if(calendar.isDateInYesterday(date))
        {
            let comp = DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .short)
            
            return "Yesterday at \(comp)"
        }
        
        let days = DateFormatter.localizedString(from: date, dateStyle: .long, timeStyle: .short)
        
        return days
    }
    
    func offsetStringFromDateString(_ dateString: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let date = dateFormatter.date(from: dateString)! as Date
        
        return offsetStringFromDate(date)
    }
    
    //
    func toLocalStringWithFormat(dateFormat: String? = "dd.MM.yyyy") -> String {
        // change to a readable time format and change to local time zone
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone.system // does it convert also daylight saving ?
        if (NSTimeZone.system.isDaylightSavingTime()) {
            print("Daylight Saving: "+String(NSTimeZone.system.daylightSavingTimeOffset(for: self)))
        }
        let timeStamp = dateFormatter.string(from: self)
        
        return timeStamp
    }
    
    func getDateAfterAddingDaysCount(count: Int) -> Date {
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: count, to: self, options: [])!.adjustDayLightSavings
    }
    
    func liesInSameYearAs(date: Date) -> Bool {
        //check if both dates have same year component
        let comp1 = Calendar.current.dateComponents([.year], from: self)
        let comp2 = Calendar.current.dateComponents([.year], from: date)
        
        return (comp1.year! == comp2.year!)
    }
    
    func isSameDayAs(date: Date) -> Bool{
        //check if both dates have same year component
        let comp1 = Calendar.current.dateComponents([.year,.month,.day], from: self)
        let comp2 = Calendar.current.dateComponents([.year,.month,.day], from: date)
        
        return (comp1.year! == comp2.year! && comp1.month! == comp2.month! && comp1.day! == comp2.day!)
    }
    
}
