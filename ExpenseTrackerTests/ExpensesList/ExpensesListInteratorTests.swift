//
//  ExpensesListInteratorTests.swift
//  ExpenseTrackerTests
//
//  Created by Avinash on 02/09/22.
//

import XCTest
@testable import ExpenseTracker

final class ExpensesListInteratorTests: XCTestCase {

    private var dbManager: MockDatabaseManager!
    private var presenter: MockExpensesListPresenter!
    private var interactor: ExpensesListInteractor!
    private var router: MockExpensesListRouter!
    private var view: MockExpensesListView!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let registry = MockDependencyRegistry()
        registry.registerDependencies()
        
        dbManager = registry.dbManager
        interactor = ExpensesListInteractor(databaseManager: dbManager,
                                            logger: registry.logger)
        presenter = MockExpensesListPresenter()
        router = MockExpensesListRouter()
        view = MockExpensesListView()
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        interactor.presenter = presenter
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    
    func testFetchTransactions() {
        /// when
        let result = try! interactor.fetchTransactions()
        
        /// then
        XCTAssertEqual(dbManager.fetchTransactionsCallCount, 1)
        XCTAssertEqual(result.count, 0)
    }
    
    func testDeleteTransaction() {
        /// when
        interactor.delete(transaction: Transaction())
        
        /// then
        XCTAssertEqual(dbManager.deleteTransactionCallCount, 1)
    }
}

