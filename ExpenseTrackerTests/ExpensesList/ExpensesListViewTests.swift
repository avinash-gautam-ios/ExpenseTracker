//
//  ExpensesListViewTests.swift
//  ExpenseTrackerTests
//
//  Created by Avinash on 02/09/22.
//

import XCTest
@testable import ExpenseTracker

final class ExpensesListViewTests: XCTestCase {

    private var presenter: MockExpensesListPresenter!
    private var interactor: MockExpensesListInteractor!
    private var router: MockExpensesListRouter!
    private var controller: ExpensesListViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let dependencyRegistry = MockDependencyRegistry()
        dependencyRegistry.registerDependencies()
        
        interactor = MockExpensesListInteractor()
        presenter = MockExpensesListPresenter()
        router = MockExpensesListRouter()
        controller = ExpensesListViewController()
        
        presenter.interactor = interactor
        presenter.view = controller
        presenter.interactor = interactor
        presenter.router = router
        controller.presenter = presenter
        interactor.presenter = presenter
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testViewDidLoad() {
        /// when
        /// this is done to invoke view object
        let _ = controller.view
        
        /// then
        /// 1. count updated for view did load content
        /// 2. count updated for reload table
        XCTAssertEqual(presenter.viewLoadedCallCount, 1)
    }
    
    func testTableCallbacks() {
        /// when
        /// this is done to invoke view object
        let _ = controller.view
        
        /// then
        /// 1. count updated for view did load content
        /// 2. count updated for reload table
        XCTAssertEqual(presenter.viewLoadedCallCount, 1)
        
        let tableView = controller.view.subviews.first(where: { $0.isKind(of: UITableView.self) })! as! UITableView
        
        let rows = controller.tableView(tableView, numberOfRowsInSection: 1)
        XCTAssertTrue(presenter.numberOfRowsInSectionCalled)
        XCTAssertEqual(rows, 1)
        
        let sections = controller.numberOfSections(in: tableView)
        XCTAssertTrue(presenter.numberOfSectionsCalled)
        XCTAssertEqual(sections, 1)
    }
}
