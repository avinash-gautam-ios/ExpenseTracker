//
//  Execute.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation

protocol Execute {
    static func onMain(_ block: @escaping () -> Void)
}

struct ExecuteImp: Execute {
    static func onMain(_ block: @escaping () -> Void) {
        DispatchQueue.main.async {
            block()
        }
    }
}
