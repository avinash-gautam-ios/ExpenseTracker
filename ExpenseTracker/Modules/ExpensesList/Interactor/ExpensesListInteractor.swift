//
//  ExpensesListInteractor.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation

final class ExpensesListInteractor: ExpensesListPresenterToInteractorProtocol {
    
    weak var presenter: ExpensesListInteractorToPresenterProtocol?
    private let databaseManager: DatabaseManager
    private let logger: Logger
    
    init(databaseManager: DatabaseManager,
         logger: Logger) {
        self.databaseManager = databaseManager
        self.logger = logger
    }
    
    func fetchTransactions() throws -> [Transaction] {
        logger.log(type: .message, "Fetching transactions")
        return try databaseManager.fetchTransactions()
    }
    
    func delete(transaction: Transaction) {
        logger.log(type: .message, "Deleting transactions ---> \(transaction.debugDescription)")
        databaseManager.delete(transaction: transaction)
    }
    
    func computeExpense(fromTransactions transactions: [Transaction]) -> ExpenseSummary {
        var income: Double = 0
        var expense: Double = 0
        transactions.forEach {
            switch $0.type {
            case .income: income += $0.amount
            case .expense: expense += $0.amount
            }
        }
        return ExpenseSummary(income: income,
                              expense: expense,
                              balance: income - expense)
    }
}
