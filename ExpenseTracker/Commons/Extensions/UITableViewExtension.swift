//
//  TableViewExtension.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import UIKit


extension UITableView {
    func register(cell: UITableViewCell.Type...) {
        cell.forEach { self.register($0,
                                     forCellReuseIdentifier: $0.staticIdentifier) }
    }
}

