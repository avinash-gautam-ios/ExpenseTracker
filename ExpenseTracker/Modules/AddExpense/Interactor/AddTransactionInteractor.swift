//
//  AddTransactionInteractor.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation

final class AddTransactionInteractor: AddTransactionPresenterToInteractorProtocol {
    
    weak var presenter: AddTransactionInteractorToPresenterProtocol?
    
    func addTransaction(withAmount amount: Double, type: TransactionType, description: String) {
        let transaction = Transaction(context: PersistenceContainer.shared.viewContext)
        transaction.amount = amount
        transaction.type = type
        transaction.statement = description
        PersistenceContainer.shared.saveContext()
        
        /// update presenter
        presenter?.didFinishSavingTransaction()
    }
}
