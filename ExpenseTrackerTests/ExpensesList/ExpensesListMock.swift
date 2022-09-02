//
//  ExpensesListMock.swift
//  ExpenseTrackerTests
//
//  Created by Avinash on 02/09/22.
//

import Foundation
import UIKit
@testable import ExpenseTracker

final class MockExpensesListView: ExpensesListPresenterToViewProtocol {
    var presenter: ExpensesListViewToPresenterProtocol?
    
    init() { }
    
    private(set) var state: ExpensesListViewState? = nil
    private(set) var didUpdateViewStateCallCount: Int = 0
    func didUpdateViewState(_ state: ExpensesListViewState) {
        self.state = state
        didUpdateViewStateCallCount += 1
    }
}

final class MockExpensesListPresenter: ExpensesListViewToPresenterProtocol,
                                        ExpensesListInteractorToPresenterProtocol {
    var interactor: ExpensesListPresenterToInteractorProtocol?
    var router: ExpensesListPresenterToRouterProtocol?
    var view: ExpensesListPresenterToViewProtocol?
    
    init() { }
    
    private(set) var viewLoadedCallCount: Int = 0
    func viewLoaded() {
        viewLoadedCallCount += 1
    }
    
    private(set) var didTapAddTransactionButtonCallCount: Int = 0
    func didTapAddTransactionButton(fromController controller: UIViewController) {
        didTapAddTransactionButtonCallCount += 1
    }
    
    private(set) var fetchLatestTransactionsCallCount: Int = 0
    func fetchLatestTransactions() {
        fetchLatestTransactionsCallCount += 1
    }
    
    private(set) var deleteTransactionCallCount: Int = 0
    func delete(item: Transaction) {
        deleteTransactionCallCount += 1
    }
    
    private(set) var numberOfSectionsCalled: Bool = false
    func numberOfSections() -> Int {
        numberOfSectionsCalled = true
        return 1
    }
    
    private(set) var numberOfRowsInSectionCalled: Bool = false
    func numberOfRows(inSection section: Int) -> Int {
        numberOfRowsInSectionCalled = true
        return 1
    }
    
    private(set) var itemForRowInSectionCalled: Bool = false
    func itemForRow(inSection section: Int, atIndex index: Int) -> Transaction {
        itemForRowInSectionCalled = true
        return Transaction()
    }
    
    private(set) var sectionItemAtIndexCalled: Bool = false
    func sectionItem(atIndex index: Int) -> ExpensesListTableSection {
        sectionItemAtIndexCalled = true
        return .init(items: [], title: "some")
    }
    
    private(set) var removeItemCallCount: Int = 0
    func removeItem(inSection section: Int, atIndex index: Int) {
        removeItemCallCount += 1
    }
}

final class MockExpensesListInteractor: ExpensesListPresenterToInteractorProtocol {
    var presenter: ExpensesListInteractorToPresenterProtocol?
    
    init() { }
    
    private(set) var fetchTransactionsCallCount: Int = 0
    func fetchTransactions() throws -> [Transaction] {
        fetchTransactionsCallCount += 1
        return []
    }
    
    private(set) var deleteTransactionCallCount: Int = 0
    func delete(transaction: Transaction) {
        deleteTransactionCallCount += 1
    }
    
    private(set) var computeExpenseCallCount: Int = 0
    func computeExpense(fromTransactions transactions: [Transaction]) -> ExpenseSummary {
        computeExpenseCallCount += 1
        return ExpenseSummary(income: 0,
                              expense: 0,
                              balance: 0)
    }
}

final class MockExpensesListRouter: ExpensesListPresenterToRouterProtocol {
    static func createModule(databaseManager: DatabaseManager,
                             logger: Logger) -> UIViewController {
        return UIViewController()
    }
    
    private(set) var presentAddTransactionCallCount: Int = 0
    func presentAddTransaction(on controller: UIViewController) {
        presentAddTransactionCallCount += 1
    }
}

final class MockExpensesListDatasource: ExpensesListDatasource {
    
    private(set) var sections: [ExpensesListTableSection] = []
    
    private(set) var addMutipleTransactionsCallCount: Int = 0
    func add(transactions: [Transaction]) {
        addMutipleTransactionsCallCount += 1
    }
    
    private(set) var addTransactionCallCount: Int = 0
    func add(transaction: Transaction) {
        addTransactionCallCount += 1
    }
    
    
    private(set) var resetCallCount: Int = 0
    func reset() {
        resetCallCount += 1
    }
    
    private(set) var deleteTransactionCallCount: Int = 0
    func deleteItem(inSection section: Int, atIndex index: Int) {
        deleteTransactionCallCount += 1
    }
}
