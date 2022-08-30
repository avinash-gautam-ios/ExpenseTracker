//
//  ExpenseSummaryItemView.swift
//  ExpenseTracker
//
//  Created by Avinash on 30/08/22.
//

import UIKit


final class ExpenseSummaryItemView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = Theme.Font.titleFont
        label.textColor = Theme.Color.descriptionColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Theme.Font.descriptionFont
        label.textAlignment = .center
        label.textColor = Theme.Color.descriptionColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        titleLabel.text = "-"
        amountLabel.text = "-"
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Theme.Padding.padding10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.Padding.padding5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.Padding.padding5),
            titleLabel.heightAnchor.constraint(equalToConstant: 2 * Theme.Padding.padding10)
        ])
        
        addSubview(amountLabel)
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Theme.Padding.padding10),
            amountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.Padding.padding5),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.Padding.padding5),
            amountLabel.heightAnchor.constraint(equalToConstant: 2 * Theme.Padding.padding10),
            amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Theme.Padding.padding10)
        ])
    }
    
    func configure(withTitle title: String, amount: Double) {
        titleLabel.text = title
        amountLabel.text = String(format: "$%0.2f", amount.rounded(toPlaces: 2))
    }
}
