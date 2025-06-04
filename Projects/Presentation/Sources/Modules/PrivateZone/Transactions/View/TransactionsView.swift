//
//  TransactionsView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import SnapKit
import Common
import Domain
import Reusable

protocol TransactionsViewOutput: AnyObject {
    func viewDidLoad()
    func addButtonDidPressed()
}

protocol TransactionsViewInput: AnyObject {
    var output: TransactionsViewOutput? { get set }
    
    func showError(_ error: TransactionsViewError)
    func setTransactionSections(_ sections: [TransactionSectionEntity])
}

final class TransactionsView: UIViewController, TransactionsViewInput {
    var output: TransactionsViewOutput?
    
    private lazy var tableView = UITableView(frame: view.bounds) &> {
        $0.dataSource = self
        $0.delegate = self
        $0.register(cellType: TransactionTitleCellView.self)
        $0.rowHeight = UITableView.automaticDimension
    }
    
    private var sections: [TransactionSectionEntity] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        output?.viewDidLoad()
        setupViews()
        setupNavigationBar()
    }
    
    func showError(_ error: TransactionsViewError) {
        showAlert(type: .error(error))
    }
    
    func setTransactionSections(_ sections: [TransactionSectionEntity]) {
        defer { tableView.reloadData() }
        self.sections = sections
    }
}

// MARK: - Subviews

extension TransactionsView {
    func setupViews() {
        view.addSubview(tableView)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Strings.Transactions.systemTitle
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonPressed)
        )
        
        navigationItem.rightBarButtonItem = addButton
    }
}

// MARK: - Private Methods

extension TransactionsView {
    @objc
    func addButtonPressed() {
        output?.addButtonDidPressed()
    }
}

// MARK: - UITableViewDataSource

extension TransactionsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let currentSection = sections[section]
//        return DateFomatter.toMonthAndDayString(from: currentSection.date)
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let currentSection = sections[section]
        let view = DateAndAmountHeaderView()
        view.configure(date: currentSection.date, amount: currentSection.amount)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TransactionTitleCellView.self)
        let section = sections[indexPath.section]
        let transaction = section.transactions[indexPath.row]
        cell.configure(with: transaction)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TransactionsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}

// MARK: - Errors

enum TransactionsViewError: LocalizedError {
    case backend
    
    var errorDescription: String? {
        switch self {
        case .backend: Strings.Error.backend
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct TransactionsViewPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(
            rootViewController: TransactionsAssembly.createMock()
        ).asPreview()
    }
}
#endif
