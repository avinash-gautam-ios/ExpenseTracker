//
//  ExpensesListDatasource.swift
//  ExpenseTracker
//
//  Created by Avinash on 29/08/22.
//

import Foundation

protocol ExpensesListDatasource {
    
    var sections: [ExpensesListTableSection] { get }
    
    func add(transactions: [Transaction])
    
    func add(transaction: Transaction)
 
    func reset()
    
    func deleteItem(inSection section: Int, atIndex index: Int)
}


struct ExpensesListTableSection {
    let items: [Transaction]
    let title: String
}

final class ExpensesListDatasourceImp: ExpensesListDatasource {
    
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
        let transactionDateString = transaction.createdAt.toString()
        if let index = sections.firstIndex(where: { $0.title == transactionDateString }) {
            let section = sections[index]
            var items = section.items
            items.append(transaction)
            let newSection = ExpensesListTableSection(items: items,
                                                      title: section.title)
            sections[index] = newSection
        } else {
            /// else, add new section with this new item
            let newSection = ExpensesListTableSection(items: [transaction],
                                                      title: transactionDateString)
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
                                                          title: sectionData.title)
            sections[section] = newSectionData
        } else {
            sections.remove(at: section)
        }
    }
}

