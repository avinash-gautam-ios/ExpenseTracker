//
//  DoubleExtension.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
