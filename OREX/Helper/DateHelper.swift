//
//  DateHelper.swift
//  OREX
//
//  Created by admin on 18/10/2024.
//

import Foundation

class DateHelper {
    static let shared = DateHelper(); private init() { }
    
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    func dateArrayToString(_ dates: [Date]) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        var result: [String] = []
        for date in dates {
            result.append(dateFormatter.string(from: date))
        }
        return result
    }
}

extension Date {
    
    static var capitalizedFirstLettersOfWeekday: [String] {
        let calendar = Calendar.current
        let weekdays = calendar.weekdaySymbols // .shortWeekdaySymbols
        
        return weekdays.map { weekday in
            guard let firstLetter = weekday.first else { return "" }
            return String(firstLetter).capitalized
        }
    }
    
    static var fulMonthNames: [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        
        return (1...12).compactMap { month in
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            let date = Calendar.current.date(from: DateComponents(year: 2000, month: month, day: 1))
            return date.map{ dateFormatter.string(from: $0) }
        }
    }
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    var startOfPreviousMonth: Date {
        let dayInPreviosMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviosMonth.startOfMonth
    }
    
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }
    
    var sundayBeforeStart: Date {
        let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
        let numberFromPreviosMonth = startOfMonthWeekday - 1
        return Calendar.current.date(byAdding: .day, value: -numberFromPreviosMonth, to: startOfMonth)!
    }
    
    var calendarDisplayDays: [Date] {
        var days: [Date] = []
        
        for dayOffset in 0..<numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth)!
            days.append(newDay)
        }
        
        for dayOffset in 0..<startOfPreviousMonth.numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfPreviousMonth)!
            days.append(newDay)
        }
        return days.filter { $0 >= sundayBeforeStart && $0 <= endOfMonth }.sorted(by: <)
    }
    
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var yearInt: Int {
        Calendar.current.component(.year, from: self)
    }
    
    var dayInt: Int {
        Calendar.current.component(.day, from: self)
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
}
