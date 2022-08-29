//
//  TransactionTypeTableCell.swift
//  ExpenseTracker
//
//  Created by Avinash on 29/08/22.
//

import UIKit

final class TransactionTypeTableCell: UITableViewCell {
    
    struct Model {
        let title: String
        let options: [RadioButtonOption]
        let selectedIndex: Int
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    init() {
        super.init(style: .default,
                   reuseIdentifier: ExpensesListTableViewCell.staticIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withModel model: TransactionTypeTableCell.Model) {
        let radioButtonView = RadioButtonView(title: model.title,
                                              selectionImage: Theme.Image.circleFilled,
                                              deselectionImage: Theme.Image.circleUnfilled,
                                              options: model.options,
                                              layout: .horizontal,
                                              defaultSelectedOptionIndex: model.selectedIndex)
        radioButtonView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(radioButtonView)
        NSLayoutConstraint.activate([
            radioButtonView.topAnchor.constraint(equalTo: contentView.topAnchor),
            radioButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            radioButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            radioButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
