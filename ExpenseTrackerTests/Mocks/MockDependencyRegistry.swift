//
//  MockDependencyRegistry.swift
//  ExpenseTrackerTests
//
//  Created by Avinash on 02/09/22.
//

import Foundation
@testable import ExpenseTracker

/*
 * MockDependencyRegistry will be used in test target only.
 * Use this to test mock the shared dependencies
 * Dont forget to call the register dependencies method, where you should register the mock dependencies
    
            Usage:
 
                let registry = MockDependencyRegistry()
                registry.registerDependencies()
 
 */

final class MockDependencyRegistry: RootDependencyRegistry {
    
    init() { }
    
    func registerDependencies() {
        /// database manager
        DependencyManagerImp.shared.register(MockDatabaseManager.self) {
            return MockDatabaseManager()
        }
        
        DependencyManagerImp.shared.register(MockLogger.self) {
            return MockLogger()
        }
    }
    
    var dbManager: MockDatabaseManager! {
        return DependencyManagerImp.shared.resolve(MockDatabaseManager.self)!
    }
    
    var logger: MockLogger {
        return DependencyManagerImp.shared.resolve(MockLogger.self)!
    }
}
