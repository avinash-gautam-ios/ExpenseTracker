//
//  ExpensesListInteractor.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation

final class ExpensesListInteractor: ExpensesListPresenterToInteractorProtocol {
    
    weak var presenter: ExpensesListInteractorToPresenterProtocol?
    
    func fetchTransactions(_ completion: @escaping ([Transaction]?, Error?) -> Void) {
        let request = Transaction.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "dateAdded",
                                                    ascending: false)]
        do {
            let results = try PersistenceContainer.shared.viewContext.fetch(request) as! [Transaction]
            completion(results, nil)
        } catch {
            completion(nil, error)
        }
    }
}
