//
//  StringExtension.swift
//  ExpenseTracker
//
//  Created by Avinash on 29/08/22.
//

import Foundation

extension String{
    func isDecimal() -> Bool{
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.locale = Locale.current
        return formatter.number(from: self) != nil
    }
}
