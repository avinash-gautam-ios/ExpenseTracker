//
//  ExpensesListDatasource.swift
//  ExpenseTracker
//
//  Created by Avinash on 29/08/22.
//

import Foundation

struct ExpensesListTableSection {
    let items: [Transaction]
    let title: String
    let date: Date
}

final class ExpensesListDatasource {
    
    private(set) var sections: [ExpensesListTableSection] = []
    
    init() { }
    
    func add(transactions: [Transaction]) {
        for transaction in transactions {
            add(transaction: transaction)
        }
    }
    
    func add(transaction: Transaction) {
        if let index = sections.firstIndex(where: { $0.date == DateFormatter.dateRemovingExtras(fromDate: transaction.dateAdded) }) {
            let section = sections[index]
            var items = section.items
            items.append(transaction)
            let newSection = ExpensesListTableSection(items: items,
                                                      title: section.title,
                                                      date: section.date)
            sections[index] = newSection
        } else {
            let date = DateFormatter.dateRemovingExtras(fromDate: transaction.dateAdded)
            let title = DateFormatter.toString(forDate: transaction.dateAdded)
            let newSection = ExpensesListTableSection(items: [transaction],
                                                      title: title,
                                                      date: date)
            sections.append(newSection)
        }
    }
    
    func reset() {
        sections.removeAll()
    }
}

