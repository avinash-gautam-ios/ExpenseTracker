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
    
    /// route to the add transaction screen
    /// uses, modal presentation
    ///
    
    func presentAddTransaction(on controller: UIViewController) {
        let addTransactionController = AddTransactionRouter.createModule()
        let navController = UINavigationController(rootViewController: addTransactionController)
        controller.present(navController, animated: true, completion: nil)
    }
}
