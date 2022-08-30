//
//  ExpensesListInteractor.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation

final class ExpensesListInteractor: ExpensesListPresenterToInteractorProtocol {
    
    weak var presenter: ExpensesListInteractorToPresenterProtocol?
    
    private let helper = DatabaseHelper.shared
    
    func fetchTransactions() throws -> [Transaction] {
        try helper.fetchTransactions()
    }
    
    func delete(transaction: Transaction) {
        helper.deleteTransaction(item: transaction)
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
