//
//  ExpensesListViewController.swift
//  ExpenseTracker
//
//  Created by Avinash on 22/08/22.
//

import UIKit

final class ExpensesListViewController: UIViewController {

    var presenter: ExpensesListViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ExpensesListViewController: ExpensesListPresenterToViewProtocol {
    
}
