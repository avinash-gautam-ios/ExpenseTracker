//
//  AddExpensePresenter.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation

final class AddExpensePresenter: AddExpenseViewToPresenterProtocol {
    var interactor: AddExpensePresenterToInteractorProtocol?
    var router: AddExpensePresenterToRouterProtocol?
    weak var view: AddExpensePresenterToViewProtocol?
    
    func viewLoaded() {
        
    }
}

extension AddExpensePresenter: AddExpenseInteractorToPresenterProtocol {
    
}
