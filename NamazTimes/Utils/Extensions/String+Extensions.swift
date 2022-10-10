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
    
    func toDate(format: Date.Time) -> Date {
        let df = DateFormatter()
        df.dateFormat = format.string
        df.locale = .current
        let date = df.date(from: self)
        return date ?? Date()
    }
        
    func toTimeInterval(format: Date.Time) -> TimeInterval {
        let date = self.toDate(format: format)
        return date.timeIntervalSince1970
    }
    
    func concatenateWithSapce(_ word: String?) -> String {
        return self + " " + ((word ?? "") ?? "")
    }
}
