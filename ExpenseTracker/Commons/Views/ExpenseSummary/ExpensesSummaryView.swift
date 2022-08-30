//
//  ExpensesSummaryView.swift
//  ExpenseTracker
//
//  Created by Avinash on 30/08/22.
//

import Foundation
import UIKit


struct ExpenseSummary {
    let income: Double
    let expense: Double
    let balance: Double
}

final class ExpensesSummaryView: UIView {
    
    private let summaryContainerView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 10
        return view
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .systemGreen
        return progressView
    }()
    
    private let expenseItemView: ExpenseSummaryItemView = {
        let view = ExpenseSummaryItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let incomeItemView: ExpenseSummaryItemView = {
        let view = ExpenseSummaryItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let balanceItemView: ExpenseSummaryItemView = {
        let view = ExpenseSummaryItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        layer.borderColor = UIColor.systemGray.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = Theme.CornerRadius.default
        
        addSubview(summaryContainerView)
        NSLayoutConstraint.activate([
            summaryContainerView.topAnchor.constraint(equalTo: topAnchor, constant: Theme.Padding.padding0),
            summaryContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.Padding.padding0),
            summaryContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Theme.Padding.padding0)
        ])
        
        summaryContainerView.addArrangedSubview(expenseItemView)
        summaryContainerView.addArrangedSubview(incomeItemView)
        summaryContainerView.addArrangedSubview(balanceItemView)
        
        addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.Padding.padding20),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.Padding.padding20),
            progressView.topAnchor.constraint(equalTo: summaryContainerView.bottomAnchor, constant: Theme.Padding.padding10),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Theme.Padding.padding10)
        ])
        
        /// default
        expenseItemView.configure(withTitle: AppStrings.expensesText, amount: 0)
        incomeItemView.configure(withTitle: AppStrings.transactionTypeIncome, amount: 0)
        balanceItemView.configure(withTitle: AppStrings.balanceText, amount: 0)
    }
    
    func configure(withSummary summary: ExpenseSummary) {
        expenseItemView.configure(withTitle: AppStrings.expensesText, amount: summary.expense)
        incomeItemView.configure(withTitle: AppStrings.transactionTypeIncome, amount: summary.income)
        balanceItemView.configure(withTitle: AppStrings.balanceText, amount: summary.balance)
        progressView.progress = Float(summary.expense/summary.income)
    }
    
}
