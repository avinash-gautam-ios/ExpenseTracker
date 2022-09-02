//
//  AddTransactionRouter.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation
import UIKit

final class AddTransactionRouter: AddTransactionPresenterToRouterProtocol {
    
    private let databaseManager: DatabaseManager
    private let logger: Logger
    
    init(databaseManager: DatabaseManager,
         logger: Logger) {
        self.databaseManager = databaseManager
        self.logger = logger
    }
    
    static func createModule(databaseManager: DatabaseManager,
                             logger: Logger) -> UIViewController {
        let controller = AddTransactionViewController()
        let presenter = AddTransactionPresenter(logger: logger)
        let interactor = AddTransactionInteractor(databaseManager: databaseManager,
                                                  logger: logger)
        let router = AddTransactionRouter(databaseManager: databaseManager,
                                          logger: logger)
        
        presenter.view = controller
        presenter.interactor = interactor
        presenter.router = router
        
        controller.presenter = presenter
        interactor.presenter = presenter
        
        return controller
    }
}
