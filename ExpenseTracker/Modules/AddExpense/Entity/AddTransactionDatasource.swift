//
//  AddTransactionDatasource.swift
//  ExpenseTracker
//
//  Created by Avinash on 29/08/22.
//

import Foundation
import UIKit

enum AddTransactionCellType {
    case transactionType(model: TransactionTypeTableCell.Model)
    case transactionDescription(model: TransactionTextFieldTableCell.Model)
    case transactionAmount(model: TransactionTextFieldTableCell.Model)
    
    var rowHeight: CGFloat {
        switch self {
        case .transactionType(_):
            return 80.0
        case .transactionDescription(_):
            return UITableView.automaticDimension
        case .transactionAmount(_):
            return UITableView.automaticDimension
        }
    }
}

extension AddTransactionCellType: Equatable {
    static func == (lhs: AddTransactionCellType, rhs: AddTransactionCellType) -> Bool {
        switch (lhs, rhs) {
        case (.transactionType(_), .transactionType(_)):
            return true
        case (.transactionDescription(_), .transactionDescription(_)):
            return true
        case (.transactionAmount(_), .transactionAmount(_)):
            return true
        default:
            return false
        }
    }
}

struct AddTransactionTableDatasource {
    
    let cells: [AddTransactionCellType]
    
    init() {
        /// transaction types
        let options = [TransactionType.income,
                       TransactionType.expense]
        let transactionTypeModel = TransactionTypeTableCell.Model(title: AppStrings.transactionType, options: options, selectedIndex: 0)
        
        /// transaction description
        let transactionDescriptionModel = TransactionTextFieldTableCell.Model(keyboardType: .default, placeholder: AppStrings.textfieldDescription, symbolText: nil, title: AppStrings.transactionDescription)
        
        /// transaction amount
        let transactionAmountModel = TransactionTextFieldTableCell.Model(keyboardType: .decimalPad, placeholder: AppStrings.transactionAmountDescription, symbolText: AppStrings.currencySymbol, title: AppStrings.transactionAmount)
        
        /// define cells
        cells = [.transactionType(model: transactionTypeModel),
                 .transactionDescription(model: transactionDescriptionModel),
                 .transactionAmount(model: transactionAmountModel)]
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return cells.count
    }
    
    func heightForRow(atIndex index: Int) -> CGFloat {
        return cells[index].rowHeight
    }
    
    func dataForRow(atIndex index: Int) -> AddTransactionCellType {
        return cells[index]
    }
}
