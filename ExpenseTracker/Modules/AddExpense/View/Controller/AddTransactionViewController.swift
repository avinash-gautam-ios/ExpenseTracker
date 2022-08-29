//
//  AddTransactionViewController.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import UIKit
import Combine


/// View states defining custom events for the AddTransactionViewController
///

enum AddTransactionViewState {
    /// load basic content on the screen
    case content(buttonTitle: String)
    
    /// reload table
    case reloadTable
    
    /// dismiss the view
    case dismiss
}

final class AddTransactionViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.separatorInset = .zero
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Theme.Color.buttonColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var presenter: AddTransactionViewToPresenterProtocol?
    private var buttonBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupKeyboardNotifications()
        presenter?.viewLoaded()
    }
    
    private func configureUI() {
        navigationItem.title = AppStrings.addTransactionPageTitle
        view.backgroundColor = Theme.BackgroundColor.viewBackgroundColor
        tableView.backgroundColor = Theme.BackgroundColor.viewBackgroundColor
        tableView.register(cell: TransactionTypeTableCell.self, TransactionTextFieldTableCell.self)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Padding.padding0),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Theme.Padding.padding0),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Theme.Padding.padding0)
        ])
        
        view.addSubview(addButton)
        addButton.addTarget(self,
                            action: #selector(addButtonAction),
                            for: .touchUpInside)
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Theme.Padding.padding10),
            addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.Padding.padding20),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.Padding.padding20)
        ])
        
        buttonBottomConstraint = addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Theme.Padding.padding10)
        buttonBottomConstraint?.isActive = true
    }
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            buttonBottomConstraint?.constant = -keyboardHeight - Theme.Padding.padding10
            
            let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func addButtonAction() {
        var transactionType: TransactionType?
        var transactionDescription: String?
        var transactionAmount: String?
        
        let rows = tableView.numberOfRows(inSection: 0)
        for index in 0...rows {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                /// check if cell is of type transaction type
                if let transactionTypeCell = cell as? TransactionTypeTableCell {
                    transactionType = transactionTypeCell.selectedOption
                }
                
                /// check if cell is of type transaction description
                if let cell = cell as? TransactionTextFieldTableCell {
                    switch cell.cellType {
                    case .transactionDescription(_):
                        transactionDescription = cell.value
                    case .transactionAmount(_):
                        transactionAmount = cell.value
                    default: break
                    }
                }
            }
        }
        
        /// pass the data to presenter for further validations
        ///
        presenter?.didTapAddButton(transactionType: transactionType,
                                   description: transactionDescription,
                                   amount: transactionAmount)
    }
}

extension AddTransactionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = presenter?.dataForRow(atIndex: indexPath.row) else {
            return UITableViewCell()
        }
        
        switch data {
        case .transactionType(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTypeTableCell.staticIdentifier)
                .flatMap { $0 as? TransactionTypeTableCell } ?? TransactionTypeTableCell()
            cell.configure(withModel: model)
            return cell
        case .transactionDescription(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTextFieldTableCell.staticIdentifier)
                .flatMap { $0 as? TransactionTextFieldTableCell } ?? TransactionTextFieldTableCell()
            cell.makeFirstResponder()
            cell.updateCellType(cellType: data)
            cell.configure(withModel: model)
            return cell
        case .transactionAmount(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTextFieldTableCell.staticIdentifier)
                .flatMap { $0 as? TransactionTextFieldTableCell } ?? TransactionTextFieldTableCell()
            cell.updateCellType(cellType: data)
            cell.configure(withModel: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter?.heightForRow(atIndex: indexPath.row) ?? UITableView.automaticDimension
    }
}

extension AddTransactionViewController: AddTransactionPresenterToViewProtocol {
    func didUpdateViewState(_ state: AddTransactionViewState) {
        switch state {
        case .reloadTable:
            tableView.reloadData()
        case .content(buttonTitle: let title):
            addButton.setTitle(title, for: .normal)
        case .dismiss:
            dismiss(animated: true, completion: nil)
        }
    }
    
    func showErrorAlert(withMessage message: String) {
        let action = UIAlertAction(title: AppStrings.okString,
                                   style: .default) { _ in }
        let alert = UIAlertController(title: AppStrings.genericErrorTitle,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
