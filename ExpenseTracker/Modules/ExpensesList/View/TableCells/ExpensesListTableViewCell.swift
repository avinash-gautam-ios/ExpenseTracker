//
//  ExpensesListTableViewCell.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import UIKit


final class ExpensesListTableViewCell: UITableViewCell {
    
    private let transactionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = Theme.Font.descriptionFont
        label.textColor = Theme.Color.descriptionColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let transactionAmountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Theme.Font.amountFont
        label.textAlignment = .right
        label.textColor = Theme.Color.descriptionColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        /// start configuring ui
        configureUI()
    }
    
    init() {
        super.init(style: .default,
                   reuseIdentifier: ExpensesListTableViewCell.staticIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        transactionDescriptionLabel.text = ""
        transactionAmountLabel.text = ""
        transactionAmountLabel.textColor = Theme.Color.descriptionColor
    }
    
    private func configureUI() {
        contentView.backgroundColor = Theme.BackgroundColor.cellBackgroundColor
        
        /// description label
        contentView.addSubview(transactionDescriptionLabel)
        transactionDescriptionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        transactionDescriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        NSLayoutConstraint.activate([
            transactionDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Theme.Padding.padding10),
            transactionDescriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Theme.Padding.padding10),
            transactionDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Theme.Padding.padding10)
        ])
        
        /// amount label
        contentView.addSubview(transactionAmountLabel)
        transactionAmountLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        transactionAmountLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        NSLayoutConstraint.activate([
            transactionAmountLabel.leadingAnchor.constraint(equalTo: transactionDescriptionLabel.trailingAnchor, constant: Theme.Padding.padding10),
            transactionAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.Padding.padding10),
            transactionAmountLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Theme.Padding.padding10),
        ])
    }
    
    func configure(withTransaction transaction: Transaction) {
        transactionDescriptionLabel.text = transaction.statement
        switch transaction.type {
        case .income:
            transactionAmountLabel.textColor = Theme.Color.incomeAmountColor
            transactionAmountLabel.text = String(format: "+ %.2f", transaction.amount)
        case .expense:
            transactionAmountLabel.textColor = Theme.Color.expenseAmountColor
            transactionAmountLabel.text = String(format: "- %.2f", transaction.amount)
        }
    }
}
