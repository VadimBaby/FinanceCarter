//
//  WalletsView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain
import Common

protocol WalletsViewOutput: AnyObject {
    func viewDidLoad()
    func addButtonDidPressed()
    func walletDidRemoved(_ wallet: WalletEntity)
}

protocol WalletsViewInput: AnyObject {
    var output: WalletsViewOutput? { get set }
    
    func setWallets(_ wallets: [WalletEntity])
    func showError(_ error: WalletsViewError)
    func insertWallet(_ wallet: WalletEntity)
}

final class WalletsView: UIViewController, WalletsViewInput {
    var output: WalletsViewOutput?
    
    private lazy var tableView = UITableView(frame: view.bounds) &> {
        $0.dataSource = self
        $0.delegate = self
        $0.register(cellType: WalletTitleCellView.self)
    }
    
    private var wallets: [WalletEntity] = []
    
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
        super.viewDidLoad()
        output?.viewDidLoad()
        setupViews()
        setupNavigationBar()
    }
    
    func setWallets(_ wallets: [WalletEntity]) {
        defer { tableView.reloadData() }
        self.wallets = wallets
    }
    
    func showError(_ error: WalletsViewError) {
        showAlert(type: .error(error))
    }
    
    func insertWallet(_ wallet: WalletEntity) {
        wallets.append(wallet)
        wallets.sortByCreatedAt()
        
        guard let indexOfWallet = wallets.firstIndex(where: { $0.id == wallet.id }) else { return }
        
        let indexPath = IndexPath(row: indexOfWallet, section: .zero)
        tableView.insertRows(at: [indexPath], with: .fade)
    }
}

// MARK: - Private Methods

private extension WalletsView {
    func setupViews() {
        view.addSubviews(tableView)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Strings.Wallets.systemTitle
        
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

// MARK: - Errors

enum WalletsViewError: LocalizedError {
    case backend
    
    var errorDescription: String? {
        switch self {
        case .backend: Strings.Error.backend
        }
    }
}

// MARK: - UITableViewDataSource

extension WalletsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wallets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: WalletTitleCellView.self)
        let wallet = wallets[indexPath.row]
        cell.configure(with: wallet)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let removedWallet = self.wallets.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        output?.walletDidRemoved(removedWallet)
    }
}

extension WalletsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct WalletsViewPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(
            rootViewController: WalletsAssembly.createMock()
        ).asPreview()
    }
}
#endif
