//
//  ExpensesListViewController.swift
//  ExpenseTracker
//
//  Created by Avinash on 22/08/22.
//

import UIKit


enum ExpensesListViewState {
    case empty
}


final class ExpensesListViewController: UIViewController {
    
    var presenter: ExpensesListViewToPresenterProtocol?
    
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
    
}

extension ExpensesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpensesListTableViewCell.staticIdentifier)
            .flatMap { $0 as? ExpensesListTableViewCell } ?? ExpensesListTableViewCell()
//        cell.configure(withTransaction: ds[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
