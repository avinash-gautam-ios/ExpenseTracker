//
//  DatabaseManager.swift
//  ExpenseTracker
//
//  Created by Avinash on 29/08/22.
//

import Foundation
import CoreData

final class DatabaseHelper {
    
    static let shared: DatabaseHelper = DatabaseHelper()
    
    private init() { }
    
    func fetchTransactions() throws -> [Transaction] {
        let request = Transaction.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Transaction.createdAt),
                                                    ascending: false)]
        return try PersistenceContainer.shared.viewContext.fetch(request) as! [Transaction]
    }
    
    func deleteTransaction(item: Transaction) {
        PersistenceContainer.shared.viewContext.delete(item)
        PersistenceContainer.shared.saveContext()
    }
    
    func addTransaction(amount: Double,
                        type: TransactionType,
                        statement: String) {
        let transaction = Transaction(context: PersistenceContainer.shared.viewContext)
        transaction.amount = amount
        transaction.type = type
        transaction.statement = statement
        PersistenceContainer.shared.saveContext()
    }
    
    /// other helper methods
    func deleteAll() {
        let context = PersistenceContainer.shared.newBackgroundContext()
        context.perform {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: Transaction.fetchRequest())
            deleteRequest.resultType = .resultTypeStatusOnly
            do {
                try context.execute(deleteRequest)
                try context.save()
                context.reset()
                DebugLogger.shared.log(type: .message, "All data deleted")
            } catch {
                DebugLogger.shared.log(type: .error, error.localizedDescription)
            }
        }
    }
    
    func fetchAllTransactions(ofType type: TransactionType) throws -> [Transaction] {
        let request = Transaction.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.propertiesToFetch = [#keyPath(Transaction.amount)]
        request.predicate = NSPredicate(format: "type == %@", type.rawValue)
        return try PersistenceContainer.shared.viewContext.fetch(request) as! [Transaction]
    }
}
