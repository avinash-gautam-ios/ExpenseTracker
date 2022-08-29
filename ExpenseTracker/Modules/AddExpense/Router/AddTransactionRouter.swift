//
//  AddTransactionRouter.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation
import UIKit

final class AddTransactionRouter: AddTransactionPresenterToRouterProtocol {
    
    static func createModule() -> UIViewController {
        let controller = AddTransactionViewController()
        let presenter = AddTransactionPresenter()
        let interactor = AddTransactionInteractor()
        let router = AddTransactionRouter()
        
        presenter.view = controller
        presenter.interactor = interactor
        presenter.router = router
        
        controller.presenter = presenter
        interactor.presenter = presenter
        
        return controller
    }
}
