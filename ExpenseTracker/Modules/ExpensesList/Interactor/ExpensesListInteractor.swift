//
//  ExpensesListInteractor.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation

final class ExpensesListInteractor: ExpensesListPresenterToInteractorProtocol {
    
    weak var presenter: ExpensesListInteractorToPresenterProtocol?
    
    func fetchTransactions(_ completion: @escaping ([Transaction]?, Error?) -> Void) {
        DatabaseHelper.shared.fetchTransactions(completion)
    }
    
    func delete(transaction: Transaction) {
        DatabaseHelper.shared.deleteTransaction(item: transaction)
    }
}
