//
//  TableCell.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import UIKit

extension UITableViewCell: Identifiable {
    static var staticIdentifier: String {
        return String(describing: self)
    }
    
    
}
