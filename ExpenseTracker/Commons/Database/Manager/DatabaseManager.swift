//
//  DatabaseManager.swift
//  ExpenseTracker
//
//  Created by Avinash on 02/09/22.
//

import Foundation
import CoreData

/// `DatabaseManager` is responsbile for managing all the connections to the database
/// This takes care of setting up the database, along with all the opertaions you can perform on the database

protocol DatabaseManager: AnyObject {
    
    /// use `setup()` function to load the database into memory. It uses
    /// NSPersistentContainer behind the scenes to the managedObjectModel into memory.
    /// Call this method in did:finishLaunchingWithOptions: for best experience, to make sure the database is loaded into the memory before you start performing any opertaions
    ///
    
    func setup()
    
    /// use `save()` function to save the context
    ///
    
    func save()
    
    /// fetchTransactions() is a helper method which can be used to fetch all the transactions from the database
    /// - Returns: all the transcations
    
    func fetchTransactions() throws -> [Transaction]
    
    /// delete(transaction:) can used to delete a transaction from the database
    ///
    
    func delete(transaction: Transaction)
    
    /// addTransaction(:) can used to save a new transaction to the database
    ///
    
    func addTransaction(withType type: TransactionType,
                        amount: Double,
                        statement: String)
}


final class DatabaseManagerImp: DatabaseManager {
    
    private enum Constants {
        static let databaseName = "ExpenseTracker"
    }
    
    static let shared: DatabaseManager = DatabaseManagerImp()
    
    private let container: NSPersistentContainer
    
    private init() {
        let url = Bundle(for: DatabaseManagerImp.self)
            .url(forResource: Constants.databaseName, withExtension: "momd")!
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Managed object model could not be created.")
        }
        
        self.container = NSPersistentContainer(name: Constants.databaseName,
                                               managedObjectModel: managedObjectModel)
    }
    
    func setup() {
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    }
    
    func save() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    func fetchTransactions() throws -> [Transaction] {
        let request = Transaction.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Transaction.createdAt),
                                                    ascending: false)]
        return try container.viewContext.fetch(request) as! [Transaction]
    }
    
    func delete(transaction: Transaction) {
        container.viewContext.delete(transaction)
        save()
    }
    
    func addTransaction(withType type: TransactionType,
                        amount: Double,
                        statement: String) {
        let transaction = Transaction(context: container.viewContext)
        transaction.amount = amount
        transaction.type = type
        transaction.statement = statement
        save()
    }
}

