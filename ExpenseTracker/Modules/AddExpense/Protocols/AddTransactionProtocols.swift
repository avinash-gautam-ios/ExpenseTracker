//
//  AddTransactionProtocols.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation
import UIKit


/// View -> Presenter
///

protocol AddTransactionViewToPresenterProtocol: AnyObject {
    var interactor: AddTransactionPresenterToInteractorProtocol? { get set }
    var router: AddTransactionPresenterToRouterProtocol? { get set }
    var view: AddTransactionPresenterToViewProtocol? { get set }
    
    /// inform about view being loaded
    func viewLoaded()
    
    /// inform about click event of add button
    func didTapAddButton(transactionType: TransactionType?,
                         description: String?,
                         amount: String?)
    
    /// tableview
    func numberOfSections() -> Int
    func numberOfRows(inSection section: Int) -> Int
    func heightForRow(atIndex index: Int) -> CGFloat
    func dataForRow(atIndex index: Int) -> AddTransactionCellType
}


/// Presenter -> View
///

protocol AddTransactionPresenterToViewProtocol: AnyObject {
    /// facilitates view state update events
    func didUpdateViewState(_ state: AddTransactionViewState)
    
    /// shows validation error alert on the transaction fields
    func showErrorAlert(withMessage message: String)
}


/// Presenter -> Interactor
///

protocol AddTransactionPresenterToInteractorProtocol: AnyObject {
    /// add transaction with
    /// - amount: amount for the transaction
    /// - type: representing the transaction type
    /// - description: a statement describing transaction
    func addTransaction(withAmount amount: Double,
                        type: TransactionType,
                        statement: String)
}


/// Presenter -> Router
///

protocol AddTransactionPresenterToRouterProtocol: AnyObject {
    static func createModule(databaseManager: DatabaseManager,
                             logger: Logger) -> UIViewController
}


/// Interactor -> Presenter
///

protocol AddTransactionInteractorToPresenterProtocol: AnyObject {
    /// update presenter about saving completion
    func didFinishSavingTransaction()
}

