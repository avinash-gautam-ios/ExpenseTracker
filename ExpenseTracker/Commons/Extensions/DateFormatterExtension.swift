//
//  DateFormatterExtension.swift
//  ExpenseTracker
//
//  Created by Avinash on 29/08/22.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY"
        return dateFormatter.string(from: self)
    }
}
