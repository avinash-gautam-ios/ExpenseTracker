//
//  MockDatabaseManager.swift
//  ExpenseTrackerTests
//
//  Created by Avinash on 02/09/22.
//

import Foundation
@testable import ExpenseTracker

final class MockDatabaseManager: DatabaseManager {
    
    private(set) var setupCallCount: Int = 0
    func setup() {
        setupCallCount += 1
    }
    
    private(set) var saveCallCount: Int = 0
    func save() {
        saveCallCount += 1
    }
    
    private(set) var fetchTransactionsCallCount: Int = 0
    func fetchTransactions() throws -> [Transaction] {
        fetchTransactionsCallCount += 1
        return []
    }
    
    private(set) var deleteTransactionCallCount: Int = 0
    func delete(transaction: Transaction) {
        deleteTransactionCallCount += 1
    }
    
    private(set) var addTransactionCallCount: Int = 0
    func addTransaction(withType type: TransactionType,
                        amount: Double,
                        statement: String) {
        addTransactionCallCount += 1
    }
}
