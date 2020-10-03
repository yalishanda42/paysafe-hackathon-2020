import Foundation

extension Date {
    
    ///returns hh:mma or HH:mm depending on device settings
    var custom24hourString: String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        
        let dateString = dateformatter.string(from: self)
        
        return dateString.replacingOccurrences(of: " ", with: "")
    }
    
    ///returns hh:mma or HH:mm depending on device settings
    var customShortString: String {
        let dateformatter = DateFormatter()
        dateformatter.amSymbol = "am"
        dateformatter.pmSymbol = "pm"
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short
        
        let dateString = dateformatter.string(from: self)
        
        return dateString.replacingOccurrences(of: " ", with: "")
    }
    
    ///returns MMM YYYY date
    var customShortDateString: String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM YYYY"
        
        let dateString = dateformatter.string(from: self)
        
        return dateString
    }
    
    /// Returns the number of days in the current month.
    var daysInMonth: Int? {
        let calendar = Calendar.current
        guard let month = calendar.dateInterval(of: .month, for: self) else { return nil }
        return calendar.dateComponents([.day], from: month.start, to: month.end).day
    }
    
    /// Returns the date at the end of the current day.
    var endOfDay: Date? {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)
    }
    
    /// Returns the date at the end of the current month.
    var endOfMonth: Date? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        guard let plusOneMonthDate = calendar.date(byAdding: components, to: self)
            else { return nil }
        let plusOneMonthDateComponents =
            calendar.dateComponents([.year, .month], from: plusOneMonthDate)
        return calendar.date(from: plusOneMonthDateComponents)?.addingTimeInterval(-1)
    }
    
    /// Returns the date at the end of the current week.
    var endOfWeek: Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        guard let sunday = calendar.date(from: components) else { return nil }
        return calendar.date(byAdding: .day, value: 7, to: sunday)?.addingTimeInterval(-1)
    }
    
    /// Returns the date at the end of the current year.
    var endOfYear: Date? {
        guard let startOfYear = startOfYear else { return nil }
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year], from: self)
        components.year = 1
        components.second = -1
        return calendar.date(byAdding: components, to: startOfYear)
    }
    
    /// The current hour of the day.
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    /// The day after the current date.
    var followingDay: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
    
    /// The week after the current date.
    var followingWeek: Date? {
        return Calendar.current.date(byAdding: .day, value: 7, to: self)
    }
    
    /// The month after the current date.
    var followingMonth: Date? {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)
    }
    
    /// The year after the current date.
    var followingYear: Date? {
        return Calendar.current.date(byAdding: .year, value: 1, to: self)
    }
    
    /// Noon on the current date.
    var noon: Date? {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)
    }
    
    ///returns hh:mma or HH:mm depending on device settings
    var mediumDateString: String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM d, YYYY"
        
        let dateString = dateformatter.string(from: self)
        
        return dateString
    }
    
    private func defaultDateFormatter(dateFormat: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }
    
    var shortDateFormattedString: String {
        let formatter = defaultDateFormatter(dateFormat: "MM/dd/yy")
        return formatter.string(from: self)
    }
    
    var timestampFormattedString: String {
        let formatter = defaultDateFormatter(dateFormat: "MM/dd/yy' at 'h:mma")
        return formatter.string(from: self).lowercased()
    }
    
    /// The current timestamp, including hour, with truncated minutes and seconds.
    var roundedHour: Date {
        
        let roundDateComponents = Calendar.current.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: Date())
        
        var selfTimeComponents = Calendar.current.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second], from: self)
        
        selfTimeComponents.day = roundDateComponents.day
        selfTimeComponents.month = roundDateComponents.month
        selfTimeComponents.year = roundDateComponents.year
        
        selfTimeComponents.hour = selfTimeComponents.hour
        selfTimeComponents.minute = 0
        selfTimeComponents.second = 0
        
        return Calendar.current.date(from: selfTimeComponents) ?? self
    }
    
    /// Returns the date at the start of the current day.
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    /// Returns the date at the start of the current month.
    var startOfMonth: Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)
    }
    
    /// Returns the date at the start of the current week.
    var startOfWeek: Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return calendar.date(from: components)
    }
    
    /// Returns the date at the start of the current year.
    var startOfYear: Date? {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.year], from: self))
    }
    
    var dateNoYear: String {
        let dateformatter = DateFormatter()
        dateformatter.amSymbol = "am"
        dateformatter.pmSymbol = "pm"
        dateformatter.dateFormat = "MMMM d, h:mma"
        let dateString = dateformatter.string(from: self)
        
        return dateString
    }
    
    /// Returns the year of the current date.
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var yesterday: Date {
        guard let newDate = Calendar.current.date(byAdding: .day, value: -1, to: self) else {
            return self
        }
        return newDate
    }
    
    var tomorrow: Date {
        guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: self) else {
            return self
        }
        return newDate
    }
    
    var midnight: Date {
        return Calendar(identifier: .gregorian).date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }
    
    var startOfNextDay: Date {
        return Calendar.current.nextDate(after: self, matching: DateComponents(hour: 0, minute: 0), matchingPolicy: .nextTimePreservingSmallerComponents)!
    }
    
    var millisecondsUntilTheNextDay: TimeInterval {
        return startOfNextDay.timeIntervalSince(self) * 1000
    }
    
    func minutes(from date: Date) -> Int {
        return Calendar(identifier: .gregorian).dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    /// How many minutes into the day is the sleep event?
    func secondsFromMidnight() -> Int {
        
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = calendar.dateComponents([Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second], from: self)
        
        return (3600 * dateComponents.hour!) + (60 * dateComponents.minute!) + dateComponents.second!
    }
    
    func todayFeedTime() -> Int {
        
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        let local = Date(timeInterval: seconds, since: self)
        
        let actionTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: local)
        
        return (3600 * actionTimeComponents.hour!) + (60 * actionTimeComponents.minute!)
    }
    
    /// Sets the current date of the timestamp.  The time is preserved, but the date is now.
    func actionDate() -> Date? {
        
        let calendar = Calendar(identifier: .gregorian)
        
        let actionDateComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: Date())
        
        var actionTimeComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second], from: self)
        
        actionTimeComponents.day = actionDateComponents.day
        actionTimeComponents.month = actionDateComponents.month
        actionTimeComponents.year = actionDateComponents.year
        
        actionTimeComponents.hour = actionTimeComponents.hour
        actionTimeComponents.minute = actionTimeComponents.minute
        actionTimeComponents.second = actionTimeComponents.second
        
        return calendar.date(from: actionTimeComponents) ?? nil
    }
    
    func combineTimeIntoDate(time: Date) -> Date? {
        
        let calendar = Calendar(identifier: .gregorian)
        let actionDateComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: self)
        var actionTimeComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second], from: time)
        
        actionTimeComponents.day = actionDateComponents.day
        actionTimeComponents.month = actionDateComponents.month
        actionTimeComponents.year = actionDateComponents.year
        
        return calendar.date(from: actionTimeComponents)
    }
    
    func convertDateForSqlite() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dbdate = dateFormatter.string(from: self)
        
        return dbdate
    }
    
    func dateByAdding(_ value: Int, to component: Calendar.Component) -> Date? {
        var components = DateComponents()
        components.setValue(abs(value), for: component)
        return Calendar.autoupdatingCurrent.date(byAdding: components, to: self)
    }
    
    func dateBySubstracting(_ value: Int, from component: Calendar.Component) -> Date? {
        var components = DateComponents()
        components.setValue(-abs(value), for: component)
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    func dateByStrippingTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }
    
    static func getNextNDays(_ nDays: Int) -> [Date] {
        let today = Date()
        var dates: [Date] = []
        
        for index in 0...nDays {
            if let date = today.dateByAdding(index, to: .day)?.dateByStrippingTime() {
                dates.append(date)
            }
        }
        
        return dates
    }
    
    static func calculateDistanceBetweenToday(and date: Date) -> Int {
        let differenceBetweenGiveDateAndToday = Calendar.autoupdatingCurrent.dateComponents([.day],
                                                                                               from: date,
                                                                                               to: Date())
        
        guard let daysBetweenGivenDateAndToday = differenceBetweenGiveDateAndToday.day else {
            #warning("TODO: Replace fatalError with throw")
            fatalError("Could not get days between given date \(date) in and today")
        }
        
        return daysBetweenGivenDateAndToday
    }
}

extension Date {
    
    func iso8601Formatter(with formatOptions: ISO8601DateFormatter.Options = ISO8601DateFormatter.Options()) -> String {
        let formater = ISO8601DateFormatter(formatOptions)
        return formater.string(from: self)
    }
    
    var iso8601DateTime: String {
        return iso8601Formatter(with: [.withDashSeparatorInDate, .withFullDate, .withTime, .withColonSeparatorInTime])
    }
    
    var iso8601Date: String {
        return iso8601Formatter(with: [.withDashSeparatorInDate, .withFullDate])
    }
    
    var iso8601: String {
        return iso8601Formatter(with: [.withInternetDateTime])
    }
}


// MARK: - DateComponents
extension Date {
    
    static func shortDateComponets(weekDay: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> DateComponents {
        var dateComponents = DateComponents()
        dateComponents.weekday = weekDay
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        return dateComponents
    }
}
