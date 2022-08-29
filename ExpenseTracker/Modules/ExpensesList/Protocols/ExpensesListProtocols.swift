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
}

// Presenter -> View

protocol ExpensesListPresenterToViewProtocol: AnyObject {
    
}

// Presenter -> Interactor

protocol ExpensesListPresenterToInteractorProtocol: AnyObject {
    
}

// Presenter -> Router

protocol ExpensesListPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    
    func presentAddTransaction(on controller: UIViewController)
}

// Interactor -> Presenter

protocol ExpensesListInteractorToPresenterProtocol: AnyObject {
    
}

