//
//  AddTransactionTextFieldTableCell.swift
//  ExpenseTracker
//
//  Created by Avinash on 29/08/22.
//

import UIKit


final class TransactionTextFieldTableCell: UITableViewCell {
    
    struct Model {
        let keyboardType: UIKeyboardType
        let placeholder: String
        let symbolText: String?
        let title: String
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = Theme.Font.amountFont
        label.textAlignment = .left
        label.textColor = Theme.Color.descriptionColor
        return label
    }()
    
    private let textfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.autocorrectionType = .no
        textfield.borderStyle = .roundedRect
        return textfield
    }()
        
    var value: String? {
        return textfield.text
    }
    
    private(set) var cellType: AddTransactionCellType?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        textfield.leftViewMode = .never
    }
    
    private func configureUI() {
        contentView.backgroundColor = Theme.BackgroundColor.cellBackgroundColor
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.Padding.padding10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.Padding.padding5),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Theme.Padding.padding5),
        ])
        
        contentView.addSubview(textfield)
        NSLayoutConstraint.activate([
            textfield.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Theme.Padding.padding5),
            textfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.Padding.padding10),
            textfield.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.Padding.padding10),
            textfield.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Theme.Padding.padding10)
        ])
    }
    
    func makeFirstResponder() {
        textfield.becomeFirstResponder()
    }
    
    func updateCellType(cellType: AddTransactionCellType) {
        self.cellType = cellType
    }
    
    func configure(withModel model: Model) {
        titleLabel.text = model.title
        textfield.keyboardType = model.keyboardType
        textfield.placeholder = model.placeholder
        textfield.delegate = self
        
        if let symbolText = model.symbolText {
            let leftView = UIView()
            leftView.translatesAutoresizingMaskIntoConstraints = false
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            leftView.addSubview(label)
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: Theme.Padding.padding10),
                label.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -Theme.Padding.padding5),
                label.topAnchor.constraint(equalTo: leftView.topAnchor, constant: Theme.Padding.padding0),
                label.bottomAnchor.constraint(equalTo: leftView.bottomAnchor, constant: Theme.Padding.padding0)
            ])
            
            label.text = symbolText
            textfield.leftViewMode = .always
            textfield.leftView = leftView
        }
    }
}

extension TransactionTextFieldTableCell: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField.keyboardType == .decimalPad {
            guard !string.isEmpty else { return true }
            
            let currentText = textField.text ?? ""
            let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            return replacementText.isDecimal()
        } else {
            return true
        }
    }
}
