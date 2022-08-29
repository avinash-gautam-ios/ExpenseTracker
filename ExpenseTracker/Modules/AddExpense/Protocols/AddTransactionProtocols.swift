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
    
    /// tableview
    func numberOfSections() -> Int
    func numberOfRows(inSection section: Int) -> Int
    func heightForRow(atIndex index: Int) -> CGFloat
    func dataForRow(atIndex index: Int) -> AddTransactionCellType
}

// Presenter -> View

protocol AddTransactionPresenterToViewProtocol: AnyObject {
    func didUpdateViewState(_ state: AddTransactionViewState)
}

// Presenter -> Interactor

protocol AddTransactionPresenterToInteractorProtocol: AnyObject {
    
}

// Presenter -> Router

protocol AddTransactionPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

// Interactor -> Presenter

protocol AddTransactionInteractorToPresenterProtocol: AnyObject {
    
}

