//
//  AddTransactionInteractor.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation

final class AddTransactionInteractor: AddTransactionPresenterToInteractorProtocol {
    
    weak var presenter: AddTransactionInteractorToPresenterProtocol?
    private let databaseManager: DatabaseManager
    private let logger: Logger
    
    init(databaseManager: DatabaseManager,
         logger: Logger) {
        self.databaseManager = databaseManager
        self.logger = logger
    }
    
    func addTransaction(withAmount amount: Double,
                        type: TransactionType,
                        statement: String) {
        databaseManager.addTransaction(withType: type,
                                       amount: amount,
                                       statement: statement)
        
        /// update presenter
        presenter?.didFinishSavingTransaction()
    }
}
