//
//  AddTransactionProtocols.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation
import UIKit

// View -> Presenter

protocol AddTransactionViewToPresenterProtocol: AnyObject {
    var interactor: AddTransactionPresenterToInteractorProtocol? { get set }
    var router: AddTransactionPresenterToRouterProtocol? { get set }
    var view: AddTransactionPresenterToViewProtocol? { get set }
    
    func viewLoaded()
    func didTapAddButton(transactionType: TransactionType?,
                         description: String?,
                         amount: String?)
    
    /// tableview
    func numberOfSections() -> Int
    func numberOfRows(inSection section: Int) -> Int
    func heightForRow(atIndex index: Int) -> CGFloat
    func dataForRow(atIndex index: Int) -> AddTransactionCellType
}

// Presenter -> View

protocol AddTransactionPresenterToViewProtocol: AnyObject {
    func didUpdateViewState(_ state: AddTransactionViewState)
    func showErrorAlert(withMessage message: String)
}

// Presenter -> Interactor

protocol AddTransactionPresenterToInteractorProtocol: AnyObject {
    func addTransaction(withAmount amount: Double,
                        type: TransactionType,
                        description: String)
}

// Presenter -> Router

protocol AddTransactionPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

// Interactor -> Presenter

protocol AddTransactionInteractorToPresenterProtocol: AnyObject {
    func didFinishSavingTransaction()
}

