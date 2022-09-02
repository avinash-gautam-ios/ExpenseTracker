//
//  ExpensesListPresenterTests.swift
//  ExpenseTrackerTests
//
//  Created by Avinash on 02/09/22.
//

import XCTest
@testable import ExpenseTracker

final class ExpenseListPresenterTests: XCTestCase {

    private var presenter: ExpensesListPresenter!
    private var interactor: MockExpensesListInteractor!
    private var router: MockExpensesListRouter!
    private var view: MockExpensesListView!
    private var datasource: MockExpensesListDatasource!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let registry = MockDependencyRegistry()
        registry.registerDependencies()
        
        datasource = MockExpensesListDatasource()
        presenter = ExpensesListPresenter(logger: registry.logger,
                                          datasource: datasource)
        interactor = MockExpensesListInteractor()
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

    func testViewLoaded() {
        /// when
        presenter.viewLoaded()
        
        /// then
        /// 1. stateCount updated inside ViewLoaded for Content
        /// 2. stateCount updated inside FetchTransactions for reloadTable
        /// 3. stateCount updated inside FetchTransactions for Content
        XCTAssertEqual(view.didUpdateViewStateCallCount, 3)
        XCTAssertEqual(interactor.fetchTransactionsCallCount, 1)
        XCTAssertEqual(datasource.addMutipleTransactionsCallCount, 1)
        switch view.state {
        case .content(buttonTitle: let buttonTitle,
                      expenseSummary: let summary):
            XCTAssertEqual(buttonTitle, AppStrings.addTransactionPageTitle)
            XCTAssertEqual(summary.balance, 0)
            XCTAssertEqual(summary.income, 0)
            XCTAssertEqual(summary.expense, 0)
        default:
            XCTFail("Expected view state was .content, but received:\(view.state.debugDescription)")
        }
    }
    
    func testFetchTransactions() {
        /// when
        presenter.fetchLatestTransactions()
        
        /// then
        /// 1. stateCount updated inside FetchTransactions for reloadTable
        /// 2. stateCount updated inside FetchTransactions for Content
        XCTAssertEqual(view.didUpdateViewStateCallCount, 2)
        XCTAssertEqual(interactor.fetchTransactionsCallCount, 1)
        XCTAssertEqual(datasource.addMutipleTransactionsCallCount, 1)
        switch view.state {
        case .content(buttonTitle: let buttonTitle,
                      expenseSummary: let summary):
            XCTAssertEqual(buttonTitle, AppStrings.addTransactionPageTitle)
            XCTAssertEqual(summary.balance, 0)
            XCTAssertEqual(summary.income, 0)
            XCTAssertEqual(summary.expense, 0)
        default:
            XCTFail("Expected view state was .content, but received:\(view.state.debugDescription)")
        }
    }
    
    func testDeleteTransaction() {
        /// when
        presenter.delete(item: Transaction())
        
        /// then
        XCTAssertEqual(interactor.deleteTransactionCallCount, 1)
    }
    
    func testRemoveItem() {
        /// when
        presenter.removeItem(inSection: 0, atIndex: 0)
        
        /// then
        XCTAssertEqual(datasource.deleteTransactionCallCount, 1)
    }
    
    func testDidTapAddTransactionButton() {
        /// when
        presenter.didTapAddTransactionButton(fromController: UIViewController())
        
        /// then
        XCTAssertEqual(router.presentAddTransactionCallCount, 1)
    }
    
}
