//
//  ExpensesListRouter.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation
import UIKit

final class ExpensesListRouter: ExpensesListPresenterToRouterProtocol {
    
    static func createModule() -> UIViewController {
        let controller = ExpensesListViewController()
        let presenter = ExpensesListPresenter()
        let interactor = ExpensesListInteractor()
        let router = ExpensesListRouter()
        
        presenter.view = controller
        presenter.interactor = interactor
        presenter.router = router
        
        controller.presenter = presenter
        interactor.presenter = presenter
        
        return controller
    }
}
