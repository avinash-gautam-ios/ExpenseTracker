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
    
    private let datasource: ExpensesListDatasource
    
    init() {
        self.datasource = ExpensesListDatasource()
    }
    
    func viewLoaded() {
        view?.didUpdateViewState(.content(buttonTitle: AppStrings.addTransactionPageTitle))
        setupDatabase()
        fetchLatestTransactions()
    }
    
    func fetchLatestTransactions() {
        interactor?.fetchTransactions { [weak self] transactions, error in
            guard let self = self,
                  let transactions = transactions else {
                      return
                  }
            
            /// reset datasource with latest transactions
            self.datasource.reset()
            self.datasource.add(transactions: transactions)
            
            /// update view state to reload table
            ExecuteImp.onMain {
                self.view?.didUpdateViewState(.reloadTable)
            }
        }
    }
    
    func didTapAddTransactionButton(fromController controller: UIViewController) {
        router?.presentAddTransaction(on: controller)
    }
    
    func numberOfSections() -> Int {
        return datasource.sections.count
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return datasource.sections[section].items.count
    }
    
    func dataForRow(atSection section: Int, index: Int) -> Transaction {
        return datasource.sections[section].items[index]
    }
    
    func sectionItem(atIndex index: Int) -> ExpensesListTableSection {
        return datasource.sections[index]
    }
    
    func deleteItem(inSection section: Int, atIndex index: Int) {
        let transaction = datasource.sections[section].items[index]
        datasource.deleteItem(inSection: section, atIndex: index)
        interactor?.delete(transaction: transaction)
    }
}

extension ExpensesListPresenter: ExpensesListInteractorToPresenterProtocol { }

extension ExpensesListPresenter {
    
    /// setup database notification on context saving
    /// this helps in dynamically updating the values on the UI
    /// as soon as an item is added into the database
    ///
    
    private func setupDatabase() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextDidSave),
                                               name: Notification.Name.NSManagedObjectContextDidSave,
                                               object: nil)
    }
    
    
    @objc private func contextDidSave(_ notification: Notification) {
        fetchLatestTransactions()
    }
}
