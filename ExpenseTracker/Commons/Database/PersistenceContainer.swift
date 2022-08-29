//
//  PersistenceContainer.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import Foundation
import CoreData

final class PersistenceContainer: NSPersistentContainer {
    
    static let shared = PersistenceContainer(name: "ExpenseTracker",
                                             managedObjectModel: sharedModel)
    
    private static let sharedModel: NSManagedObjectModel = {
        let url = Bundle(for: PersistenceContainer.self)
            .url(forResource: "ExpenseTracker", withExtension: "momd")!
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Managed object model could not be created.")
        }
        return managedObjectModel
    }()
    
    
    func setup() {
        loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    }
    
    func saveContext() { 
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
}
