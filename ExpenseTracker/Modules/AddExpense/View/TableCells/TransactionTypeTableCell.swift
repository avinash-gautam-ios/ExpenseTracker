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
        let options: [TransactionType]
        let selectedIndex: Int
    }
    
    private(set) var selectedOption: TransactionType?
    private var model: Model?
    
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
        /// cache for next use
        self.model = model
        self.selectedOption = model.options[model.selectedIndex]
        
        /// create views and add to UI
        let options = model.options.map { RadioButtonOption(value: $0.stringValue) }
        let radioButtonView = RadioButtonView(title: model.title,
                                              selectionImage: Theme.Image.circleFilled,
                                              deselectionImage: Theme.Image.circleUnfilled,
                                              options: options,
                                              layout: .horizontal,
                                              defaultSelectedOptionIndex: model.selectedIndex)
        radioButtonView.translatesAutoresizingMaskIntoConstraints = false
        radioButtonView.delegate = self
        contentView.addSubview(radioButtonView)
        NSLayoutConstraint.activate([
            radioButtonView.topAnchor.constraint(equalTo: contentView.topAnchor),
            radioButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            radioButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            radioButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension TransactionTypeTableCell: RadioButtonViewDelegate {
    func didFinishSelectingRadioOption(_ view: RadioButtonView,
                                       option: RadioButtonOption,
                                       optionIndex: Int) {
        self.selectedOption = model?.options[optionIndex]
    }
}
