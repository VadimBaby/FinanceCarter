//
//  CategoriesView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import MyCommon
import Domain

protocol CategoriesViewOutput: AnyObject {
    func viewDidLoad()
    func categoryDidRemoved(_ category: CategoryEntity)
    func addButtonDidPressed()
}

protocol CategoriesViewInput: AnyObject {
    var output: CategoriesViewOutput? { get set }
    
    func setCategories(_ categories: [CategoryEntity])
    func showError(_ error: Error)
    func insertCategory(_ category: CategoryEntity)
}

final class CategoriesView: UIViewController, CategoriesViewInput {
    var output: CategoriesViewOutput?
    
    private lazy var tableView = UITableView(frame: view.frame) &> {
        $0.register(cellType: CategoryCellView.self)
        $0.dataSource = self
        $0.delegate = self
    }
    
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
    
    private var categories: [CategoryEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        setupViews()
        setupNavigationBar()
    }
    
    func setCategories(_ categories: [CategoryEntity]) {
        defer { tableView.reloadData() }
        self.categories = categories
    }
    
    func showError(_ error: Error) {
        showAlert(type: .error(error))
    }
    
    func insertCategory(_ category: CategoryEntity) {
        categories.append(category)
        categories.sortByCreatedAt()
        
        guard let indexOfCategory = categories.firstIndex(where: { $0.id == category.id }) else { return }
        
        let indexPath = IndexPath(row: indexOfCategory, section: .zero)
        tableView.insertRows(at: [indexPath], with: .fade)
    }
}

// MARK: - Setup subviews

private extension CategoriesView {
    func setupViews() {
        view.addSubview(tableView)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Strings.Categories.systemTitle
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonPressed)
        )
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc
    func addButtonPressed() {
        output?.addButtonDidPressed()
    }
}

// MARK: - UITableViewDataSource

extension CategoriesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CategoryCellView.self)
        let category = self.categories[indexPath.row]
        cell.configure(with: category)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let removed = categories.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        output?.categoryDidRemoved(removed)
    }
}

// MARK: - UITableViewDelegate

extension CategoriesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct CategoriesViewPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: CategoriesAssembly.createMock()).asPreview()
    }
}
#endif
