//
//  ExpensesListRouterTests.swift
//  ExpenseTrackerTests
//
//  Created by Avinash on 02/09/22.
//

import XCTest
@testable import ExpenseTracker

final class ExpensesListRouterTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testCreateModule() {
        
        let dependencyRegistry = MockDependencyRegistry()
        dependencyRegistry.registerDependencies()
        
        let manager = DependencyManagerImp.shared.resolve(MockDatabaseManager.self)!
        let logger = DependencyManagerImp.shared.resolve(MockLogger.self)!
        
        let controller = ExpensesListRouter
            .createModule(databaseManager: manager,
                          logger: logger)
        XCTAssertTrue(controller.isKind(of: ExpensesListViewController.self))
    }
}

