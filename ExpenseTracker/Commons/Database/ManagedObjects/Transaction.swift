//
//  Transaction+CoreDataClass.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//
//

import Foundation
import CoreData

@objc enum TransactionType: Int64 {
    case income
    case expense
    
    var stringValue: String {
        switch self {
        case .income:
            return AppStrings.transactionTypeIncome
        case .expense:
            return AppStrings.transactionTypeExpense
        }
    }
}

final class Transaction: NSManagedObject, Identifiable {
    
    @NSManaged public var statement: String
    @NSManaged public var amount: Double
    @NSManaged public var type: TransactionType
    @NSManaged public var createdAt: Date
    
    @nonobjc public class func getFetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }
}

extension Transaction {
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        /// adding default valut to the date attribute, unless passed
        setPrimitiveValue(Date(), forKey: #keyPath(Transaction.createdAt))
    }
}
