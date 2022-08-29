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
    
    /// add transaction to the datasource
    ///
    
    func add(transaction: Transaction) {
        /// update exisiting section with new item, if it exists
        if let index = sections.firstIndex(where: { $0.date == DateFormatter.dateRemovingExtras(fromDate: transaction.dateAdded) }) {
            let section = sections[index]
            var items = section.items
            items.append(transaction)
            let newSection = ExpensesListTableSection(items: items,
                                                      title: section.title,
                                                      date: section.date)
            sections[index] = newSection
        } else {
            /// else, add new section with this new item
            let date = DateFormatter.dateRemovingExtras(fromDate: transaction.dateAdded)
            let title = DateFormatter.toString(forDate: transaction.dateAdded)
            let newSection = ExpensesListTableSection(items: [transaction],
                                                      title: title,
                                                      date: date)
            sections.append(newSection)
        }
    }
    
    /// remove all data
    ///
    
    func reset() {
        sections.removeAll()
    }
    
    /// delete item from datasource
    /// deletes the entire section if the section after removing element does not contain any item
    ///
    
    func deleteItem(inSection section: Int, atIndex index: Int) {
        let sectionData = sections[section]
        var items = sectionData.items
        items.remove(at: index)
        
        if (items.count > 0) {
            let newSectionData = ExpensesListTableSection(items: items,
                                                      title: sectionData.title,
                                                      date: sectionData.date)
            sections[section] = newSectionData
        } else {
            sections.remove(at: section)
        }
    }
}

