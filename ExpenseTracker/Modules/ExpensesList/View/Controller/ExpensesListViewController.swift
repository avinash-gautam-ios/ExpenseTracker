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
    case content(buttonTitle: String)
    
    /// reload table
    case reloadTable
    
    /// handle empty state
    case empty
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
        tableView.register(cell: ExpensesListTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        
        /// tableview
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Padding.padding0),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Theme.Padding.padding0),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Theme.Padding.padding0)
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
        case .content(let buttonTitle):
            handleContentState(buttonTitle: buttonTitle)
        case .reloadTable:
            tableView.reloadData()
        case .empty:
            handleEmptyState()
        }
    }
    
    private func handleContentState(buttonTitle: String) {
        addTransactionButton.setTitle(buttonTitle, for: .normal)
    }
    
    private func handleEmptyState() {
        //TODO: Show empty state view here
    }
}


// MARK: - Tableview

extension ExpensesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpensesListTableViewCell.staticIdentifier)
            .flatMap { $0 as? ExpensesListTableViewCell } ?? ExpensesListTableViewCell()
        cell.selectionStyle = .none
        if let presenter = presenter {
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
        return presenter?.sectionItem(atIndex: section).title ?? nil
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete),
           let presenter = presenter {
            let section = presenter.sectionItem(atIndex: indexPath.section)
            presenter.deleteItem(inSection: indexPath.section, atIndex: indexPath.row)
            
            /// check if this is the last item in section
            if section.items.count >= 2 {
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                /// if this is last item in section, remove the entire section
                tableView.deleteSections([indexPath.section], with: .fade)
            }
        }
    }
}
