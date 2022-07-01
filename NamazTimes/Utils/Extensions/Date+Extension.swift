import Foundation

extension Date {
    
    func toString(format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        let strDate = df.string(from: self)
        return strDate
    }

    enum Time {
        case full, fullMilliseconds, fullTimeZone, fullMillisecondsTimeZone, display

        var string: String {
            switch self {
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
