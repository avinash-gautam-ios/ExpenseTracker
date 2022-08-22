//
//  AddExpenseViewController.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import UIKit

class AddExpenseViewController: UIViewController {

    var presenter: AddExpenseViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension AddExpenseViewController: AddExpensePresenterToViewProtocol {
    
}
