//
//  ExpensesListPresenter.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation
import UIKit
import CoreData

final class ExpensesListPresenter: ExpensesListViewToPresenterProtocol {
    
    var interactor: ExpensesListPresenterToInteractorProtocol?
    var router: ExpensesListPresenterToRouterProtocol?
    weak var view: ExpensesListPresenterToViewProtocol?
    
    private let datasource: ExpensesListDatasource
    
    init() {
        self.datasource = ExpensesListDatasource()
    }
    
    func viewLoaded() {
        let defaultExpenseSummary = ExpenseSummary(income: 0,
                                                   expense: 0,
                                                   balance: 0)
        
        view?.didUpdateViewState(.content(buttonTitle: AppStrings.addTransactionPageTitle,
                                          expenseSummary: defaultExpenseSummary))
        setupDatabase()
        fetchLatestTransactions()
    }
    
    func fetchLatestTransactions() {
        do {
            let transactions = try interactor?.fetchTransactions()
            guard let transactions = transactions else {
                view?.didUpdateViewState(.empty)
                return
            }
            
            /// reset datasource with latest transactions
            datasource.reset()
            datasource.add(transactions: transactions)
            
            /// update view
            view?.didUpdateViewState(.reloadTable)
            
            if let expenseSummary = self.interactor?
                .computeExpense(fromTransactions: transactions) {
                self.view?.didUpdateViewState(.content(buttonTitle: AppStrings.addTransactionPageTitle,
                                                       expenseSummary: expenseSummary))
            }
        } catch {
            view?.didUpdateViewState(.error(error: error))
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
    
    func itemForRow(inSection section: Int, atIndex index: Int) -> Transaction {
        return datasource.sections[section].items[index]
    }
    
    func sectionItem(atIndex index: Int) -> ExpensesListTableSection {
        return datasource.sections[index]
    }
    
    func removeItem(inSection section: Int, atIndex index: Int) {
        datasource.deleteItem(inSection: section, atIndex: index)
    }
    
    func delete(item: Transaction) {
        interactor?.delete(transaction: item)
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
