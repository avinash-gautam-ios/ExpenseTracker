//
//  AddTransactionViewController.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import UIKit
import Combine

enum AddTransactionViewState {
    case content(buttonTitle: String)
    case reloadTable
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
    private var cancellables: Set<AnyCancellable> = []
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
        case .transactionDescription(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTextFieldTableCell.staticIdentifier)
                .flatMap { $0 as? TransactionTextFieldTableCell } ?? TransactionTextFieldTableCell()
            cell.makeFirstResponder()
            cell.configure(forCellType: data)
            return cell
        case .transactionAmount(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTextFieldTableCell.staticIdentifier)
                .flatMap { $0 as? TransactionTextFieldTableCell } ?? TransactionTextFieldTableCell()
            cell.configure(forCellType: data)
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
        }
    }
}
