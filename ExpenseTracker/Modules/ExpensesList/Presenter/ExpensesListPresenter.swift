//
//  ExpensesListPresenter.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation

final class ExpensesListPresenter: ExpensesListViewToPresenterProtocol {
    var interactor: ExpensesListPresenterToInteractorProtocol?
    var router: ExpensesListPresenterToRouterProtocol?
    weak var view: ExpensesListPresenterToViewProtocol?
    
    func viewLoaded() {
        
    }
}

extension ExpensesListPresenter: ExpensesListInteractorToPresenterProtocol {
    
}
