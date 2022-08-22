//
//  AddExpenseRouter.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation
import UIKit

final class AddExpenseRouter: AddExpensePresenterToRouterProtocol {
    
    static func createModule() -> UIViewController {
        let controller = AddExpenseViewController()
        let presenter = AddExpensePresenter()
        let interactor = AddExpenseInteractor()
        let router = AddExpenseRouter()
        
        presenter.view = controller
        presenter.interactor = interactor
        presenter.router = router
        
        controller.presenter = presenter
        interactor.presenter = presenter
        
        return controller
    }
}
