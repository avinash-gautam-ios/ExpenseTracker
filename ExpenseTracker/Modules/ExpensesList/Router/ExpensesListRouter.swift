//
//  ExpensesListRouter.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation
import UIKit

final class ExpensesListRouter: ExpensesListPresenterToRouterProtocol {
    
    /*
     * So, there are now two ways we can pass dependencies to subsequent child VIPs
     * First way is to keep the dependecies reference in the router and pass it on to the other VIPER objects
     * Other way, is to use the dependency manager directly inside classes to resolve whatever shared dependencies you want to use
     */
    
    private let databaseManager: DatabaseManager
    private let logger: Logger
    
    init(databaseManager: DatabaseManager,
         logger: Logger) {
        self.databaseManager = databaseManager
        self.logger = logger
    }
    
    static func createModule(databaseManager: DatabaseManager,
                             logger: Logger) -> UIViewController {
        let controller = ExpensesListViewController()
        let presenter = ExpensesListPresenter(logger: logger,
                                              datasource: ExpensesListDatasourceImp())
        let interactor = ExpensesListInteractor(databaseManager: databaseManager,
                                                logger: logger)
        let router = ExpensesListRouter(databaseManager: databaseManager,
                                        logger: logger)
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
        let addTransactionController = AddTransactionRouter.createModule(databaseManager: databaseManager,
                                                                         logger: logger)
        let navController = UINavigationController(rootViewController: addTransactionController)
        controller.present(navController, animated: true, completion: nil)
    }
}
