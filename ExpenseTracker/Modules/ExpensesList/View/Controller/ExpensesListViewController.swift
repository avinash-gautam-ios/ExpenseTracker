//
//  ExpensesListViewController.swift
//  ExpenseTracker
//
//  Created by Avinash on 22/08/22.
//

import UIKit
import CoreData


/// View states defining custom events for the ExpensesListViewController
///

enum ExpensesListViewState {
    /// load basic content on the screen
    case content(buttonTitle: String,
                 expenseSummary: ExpenseSummary)
    
    /// reload table
    case reloadTable
    
    /// handle empty state
    case empty
    
    /// handle error state
    case error(error: Error)
}


final class ExpensesListViewController: UIViewController {
    
    var presenter: ExpensesListViewToPresenterProtocol?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = .zero
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    private let addTransactionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Theme.Color.buttonColor
        button.layer.cornerRadius = Theme.CornerRadius.default
        return button
    }()
    
    private let summaryView: ExpensesSummaryView = {
        let view = ExpensesSummaryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewLoaded()
        configureUI()
    }
    
    private func configureUI() {
        /// navigation title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = AppStrings.expensesListPageTitle
        
        view.backgroundColor = Theme.BackgroundColor.viewBackgroundColor
        tableView.backgroundColor = Theme.BackgroundColor.viewBackgroundColor
        tableView.separatorStyle = .none
        tableView.register(cell: ExpensesListTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(summaryView)
        NSLayoutConstraint.activate([
            summaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Padding.padding0),
            summaryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.Padding.padding10),
            summaryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.Padding.padding10),
        ])
        
        /// tableview
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: Theme.Padding.padding10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.Padding.padding10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.Padding.padding10)
        ])
        
        /// button
        addTransactionButton.addTarget(self,
                                       action: #selector(addTransactionButtonAction),
                                       for: .touchUpInside)
        view.addSubview(addTransactionButton)
        NSLayoutConstraint.activate([
            addTransactionButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Theme.Padding.padding10),
            addTransactionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Theme.Padding.padding0),
            addTransactionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.Padding.padding20),
            addTransactionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.Padding.padding20)
        ])
    }
    
    @objc private func addTransactionButtonAction() {
        presenter?.didTapAddTransactionButton(fromController: self)
    }
    
}

extension ExpensesListViewController: ExpensesListPresenterToViewProtocol {
    func didUpdateViewState(_ state: ExpensesListViewState) {
        switch state {
        case .content(buttonTitle: let buttonTitle,
                      expenseSummary: let expenseSummary):
            handleContentState(buttonTitle: buttonTitle,
                               expenseSummary: expenseSummary)
        case .reloadTable:
            tableView.reloadData()
        case .empty:
            handleEmptyState()
        case .error(error: let error):
            handleErrorState(error)
        }
    }
    
    private func handleContentState(buttonTitle: String, expenseSummary: ExpenseSummary) {
        addTransactionButton.setTitle(buttonTitle, for: .normal)
        summaryView.configure(withSummary: expenseSummary)
    }
    
    private func handleEmptyState() {
        //TODO: Show empty state view here
    }
    
    private func handleErrorState(_ error: Error) {
        
    }
}


// MARK: - TableView

extension ExpensesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpensesListTableViewCell.staticIdentifier)
            .flatMap { $0 as? ExpensesListTableViewCell } ?? ExpensesListTableViewCell()
        cell.selectionStyle = .none
        if let presenter = presenter {
            let data = presenter.itemForRow(inSection: indexPath.section,
                                            atIndex: indexPath.row)
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
        return presenter?.sectionItem(atIndex: section).title ?? nil
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete),
           let presenter = presenter {
            /// 1. Remove item from datasource
            let section = presenter.sectionItem(atIndex: indexPath.section)
            let transaction = section.items[indexPath.row]
            presenter.removeItem(inSection: indexPath.section, atIndex: indexPath.row)
            
            /// 2. Remove item from tableview with animation
            
            /// check if this is the last item in section
            if section.items.count >= 2 {
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                /// if this is last item in section, remove the entire section
                tableView.deleteSections([indexPath.section], with: .fade)
            }
            
            /// 3. Update the database
            presenter.delete(item: transaction)
        }
    }
}
