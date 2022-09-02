//
//  MockLogger.swift
//  ExpenseTrackerTests
//
//  Created by Avinash on 02/09/22.
//

import Foundation
@testable import ExpenseTracker

final class MockLogger: Logger {
    
    private(set) var logCalled: Bool = false
    func log(type: LogType, _ message: Any) {
        logCalled = true
    }
    
    func reset() {
        logCalled = false
    }
}
