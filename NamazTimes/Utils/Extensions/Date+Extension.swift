import Foundation

extension Date {
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    func toString(format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        let strDate = df.string(from: self)
        return strDate
    }

    enum Time {
        case full, fullMilliseconds, fullTimeZone, fullMillisecondsTimeZone, display
        case dateTimeDisplay

        var string: String {
            switch self {
            case .dateTimeDisplay:
                return "dd-MM-yyyy HH:mm"
            case .full:
                return "HH:mm:ss"
            case .fullMilliseconds:
                return "HH:mm:ss.SSS"
            case .fullTimeZone:
                return "HH:mm:ssZ"
            case .fullMillisecondsTimeZone:
                return "HH:mm:ss.SSSZ"
            case .display:
                return " HH:mm"
            }
        }
    }

    func timeString(withFormat dateFormat: Date.Time, locale: Locale = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.string
        dateFormatter.locale = locale
        return dateFormatter.string(from: self)
    }
    
    func isEqual(to date: Date) -> Bool {
        return Calendar.current.startOfDay(for: self) == Calendar.current.startOfDay(for: date)
    }
}
