//
//  ExpensesListPresenter.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation
import UIKit

final class ExpensesListPresenter: ExpensesListViewToPresenterProtocol {
    var interactor: ExpensesListPresenterToInteractorProtocol?
    var router: ExpensesListPresenterToRouterProtocol?
    weak var view: ExpensesListPresenterToViewProtocol?
    
    func viewLoaded() {
        
    }
    
    func didTapAddTransactionButton(fromController controller: UIViewController) {
        router?.presentAddTransaction(on: controller)
    }
}

extension ExpensesListPresenter: ExpensesListInteractorToPresenterProtocol {
    
}
