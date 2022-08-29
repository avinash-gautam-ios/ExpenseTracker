//
//  OptionalExtension.swift
//  ExpenseTracker
//
//  Created by Avinash on 29/08/22.
//

import Foundation

extension Optional {
    func unwrap(_ completion: (Wrapped) -> Void) {
        switch self {
        case .none:
            break
        case .some(let wrapped):
            completion(wrapped)
        }
    }
}
