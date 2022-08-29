//
//  ExpensesListProtocols.swift
//  ExpenseTracker
//
//  Created by Avinash on 22/08/22.
//

import Foundation
import UIKit

// View -> Presenter

protocol ExpensesListViewToPresenterProtocol: AnyObject {
    var interactor: ExpensesListPresenterToInteractorProtocol? { get set }
    var router: ExpensesListPresenterToRouterProtocol? { get set }
    var view: ExpensesListPresenterToViewProtocol? { get set }
    
    func viewLoaded()
    func didTapAddTransactionButton(fromController controller: UIViewController)
    func fetchLatestTransactions()
    
    /// tableview
    func numberOfSections() -> Int
    func numberOfRows(inSection section: Int) -> Int
    func dataForRow(atSection section: Int, index: Int) -> Transaction
    func sectionItem(atIndex index: Int) -> ExpensesListTableSection
}

// Presenter -> View

protocol ExpensesListPresenterToViewProtocol: AnyObject {
    func didUpdateViewState(_ state: ExpensesListViewState)
}

// Presenter -> Interactor

protocol ExpensesListPresenterToInteractorProtocol: AnyObject {
    func fetchTransactions(_ completion: @escaping ([Transaction]?, Error?) -> Void)
}

// Presenter -> Router

protocol ExpensesListPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    
    func presentAddTransaction(on controller: UIViewController)
}

// Interactor -> Presenter

protocol ExpensesListInteractorToPresenterProtocol: AnyObject {
    
}

