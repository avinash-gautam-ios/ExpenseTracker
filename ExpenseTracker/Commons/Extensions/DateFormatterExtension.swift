//
//  DateFormatterExtension.swift
//  ExpenseTracker
//
//  Created by Avinash on 29/08/22.
//

import Foundation

extension DateFormatter {
    static func dateRemovingExtras(fromDate date: Date) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYYY"
        guard let date = formatter.date(from: formatter.string(from: date)) else {
            return date
        }
        return date
    }
    
    static func toString(forDate date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY"
        return dateFormatter.string(from: date)
    }
}
