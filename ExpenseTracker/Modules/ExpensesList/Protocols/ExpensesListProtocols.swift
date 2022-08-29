//
//  ExpensesListProtocols.swift
//  ExpenseTracker
//
//  Created by Avinash on 22/08/22.
//

import Foundation
import UIKit

/// View -> Presenter
///

protocol ExpensesListViewToPresenterProtocol: AnyObject {
    var interactor: ExpensesListPresenterToInteractorProtocol? { get set }
    var router: ExpensesListPresenterToRouterProtocol? { get set }
    var view: ExpensesListPresenterToViewProtocol? { get set }
    
    /// called to inform of view load to presenter
    func viewLoaded()
    
    /// called to inform about add transaction button action
    func didTapAddTransactionButton(fromController controller: UIViewController)
    
    /// called to fetch latest transactions
    func fetchLatestTransactions()
    
    /// tableview
    func numberOfSections() -> Int
    func numberOfRows(inSection section: Int) -> Int
    func dataForRow(atSection section: Int, index: Int) -> Transaction
    func sectionItem(atIndex index: Int) -> ExpensesListTableSection
    func deleteItem(inSection section: Int, atIndex index: Int)
}


/// Presenter -> View
///

protocol ExpensesListPresenterToViewProtocol: AnyObject {
    /// update view state
    func didUpdateViewState(_ state: ExpensesListViewState)
}


/// Presenter -> Interactor
///

protocol ExpensesListPresenterToInteractorProtocol: AnyObject {
    /// fetch transactions
    func fetchTransactions(_ completion: @escaping ([Transaction]?, Error?) -> Void)
    
    /// delete transaction
    func delete(transaction: Transaction)
}


/// Presenter -> Router
///

protocol ExpensesListPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    
    /// present the add transaction screen
    func presentAddTransaction(on controller: UIViewController)
}


/// Interactor -> Presenter
///

protocol ExpensesListInteractorToPresenterProtocol: AnyObject { }

