//
//  String+Extensions.swift
//  Namaz Times
//
//  Created by &&TairoV on 09.09.2022.
//

import Foundation

extension String {
    var localized: String {
        get {
            var lang = "kk"
            if let code: String = UserDefaults.standard.string(forKey: "language") {
                lang = code
            }
            
            guard let path = Bundle.main.path(forResource: lang, ofType: "lproj") else { return self }
            let bundle = Bundle(path: path)
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
    }
    
    func toDate(format: Date.Time = .dateTimeDisplay) -> Date {
        let timeZone = TimeZone(identifier: TimeZone.current.abbreviation() ?? "UTC")
        let df = DateFormatter()
        df.dateFormat = format.string
        df.timeZone = timeZone
        let date = df.date(from: self)?.addingTimeInterval(TimeInterval(timeZone?.secondsFromGMT() ?? 0))
        return date ?? Date()
    }
        
    func toTimeInterval() -> TimeInterval {
        let timeZone = TimeZone(identifier: TimeZone.current.abbreviation() ?? "UTC")
        let date = self.toDate().addingTimeInterval(TimeInterval(timeZone?.secondsFromGMT() ?? 0))
        return date.timeIntervalSince1970
    }
    
    func concatenateWithSapce(_ word: String?) -> String {
        return self + " " + ((word ?? ""))
    }
}
