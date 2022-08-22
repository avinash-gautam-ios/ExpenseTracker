//
//  AddExpenseProtocols.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation
import UIKit

// View -> Presenter

protocol AddExpenseViewToPresenterProtocol: AnyObject {
    var interactor: AddExpensePresenterToInteractorProtocol? { get set }
    var router: AddExpensePresenterToRouterProtocol? { get set }
    var view: AddExpensePresenterToViewProtocol? { get set }
    
    func viewLoaded()
}

// Presenter -> View

protocol AddExpensePresenterToViewProtocol: AnyObject {
    
}

// Presenter -> Interactor

protocol AddExpensePresenterToInteractorProtocol: AnyObject {
    
}

// Presenter -> Router

protocol AddExpensePresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

// Interactor -> Presenter

protocol AddExpenseInteractorToPresenterProtocol: AnyObject {
    
}

