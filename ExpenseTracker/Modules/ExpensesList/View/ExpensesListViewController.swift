//
//  ExpensesListViewController.swift
//  ExpenseTracker
//
//  Created by Avinash on 22/08/22.
//

import UIKit
import CoreData


enum ExpensesListViewState {
    case content(buttonTitle: String)
    case reloadTable
    case empty
}


final class ExpensesListViewController: UIViewController {
    
    var presenter: ExpensesListViewToPresenterProtocol?
    var transactions: [Transaction] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.separatorInset = .zero
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let addTransactionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Theme.Color.buttonColor
        button.layer.cornerRadius = Theme.CornerRadius.default
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewLoaded()
        configureUI()
    }
    
    private func configureUI() {
        navigationItem.title = AppStrings.expensesListPageTitle
        view.backgroundColor = Theme.BackgroundColor.viewBackgroundColor
        tableView.backgroundColor = Theme.BackgroundColor.viewBackgroundColor
        tableView.register(cell: ExpensesListTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        addTransactionButton.addTarget(self,
                                       action: #selector(addTransactionButtonAction),
                                       for: .touchUpInside)
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Padding.padding0),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Theme.Padding.padding0),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Theme.Padding.padding0)
        ])
        
        
        view.addSubview(addTransactionButton)
        NSLayoutConstraint.activate([
            addTransactionButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Theme.Padding.padding10),
            addTransactionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Theme.Padding.padding0),
            addTransactionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.Padding.padding20),
            addTransactionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.Padding.padding20)
        ])
    }
    
    @objc func addTransactionButtonAction() {
        presenter?.didTapAddTransactionButton(fromController: self)
    }
    
}

extension ExpensesListViewController: ExpensesListPresenterToViewProtocol {
    func didUpdateViewState(_ state: ExpensesListViewState) {
        switch state {
        case .content(let buttonTitle):
            addTransactionButton.setTitle(buttonTitle, for: .normal)
        case .reloadTable:
            tableView.reloadData()
        case .empty:
            break
        }
    }
}

extension ExpensesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpensesListTableViewCell.staticIdentifier)
            .flatMap { $0 as? ExpensesListTableViewCell } ?? ExpensesListTableViewCell()
        cell.selectionStyle = .none
        presenter.unwrap { presenter in
            let data = presenter.dataForRow(atSection: indexPath.section, index: indexPath.row)
            cell.configure(withTransaction: data)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return presenter
            .map { $0.sectionItem(atIndex: section) }
            .map { $0.title } ?? nil
    }
}
