//
//  CreateTransactionView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain
import Common
import SnapKit

protocol CreateTransactionViewOutput: AnyObject {
    func closeButtonDidPressed()
    func viewDidLoad()
    func walletDidSelect(_ wallet: WalletEntity)
    func categoryDidSelect(_ category: CategoryEntity)
    func addButtonDidPressed(amount: Double)
}

protocol CreateTransactionViewInput: AnyObject {
    var output: CreateTransactionViewOutput? { get set }
    
    func showError(_ error: CreateTransactionError)
    func setWallets(_ wallets: [WalletEntity])
    func setCategories(_ categories: [CategoryEntity])
}

private struct Constants {
    static let padding = 20
    static let textFieldHeight = 50
    static let verticalSpacingSmall = 10
    static let verticalSpacingMedium = 20
}

final class CreateTransactionView: UIViewController, CreateTransactionViewInput {
    var output: CreateTransactionViewOutput?
    
    // TODO: - Локализовать
    private lazy var amountLabel: UILabel = .textfield(text: "Сумма")
    private lazy var amountTextField: UITextField = .primary(placeholder: "Сумма") &> {
        $0.keyboardType = .numberPad
    }
    
    // TODO: - Почему у лейбла именно .textfield
    private lazy var walletLabel: UILabel = .textfield(text: "Кошелек")
    private lazy var showWalletMenuButton = UIButton(type: .system) &> {
        $0.showsMenuAsPrimaryAction = true
        $0.setTitle("Выберите кошелек", for: .normal)
    }
    
    private lazy var categoryLabel: UILabel = .textfield(text: "Категория")
    private lazy var showCategoryMenuButton = UIButton(type: .system) &> {
        $0.showsMenuAsPrimaryAction = true
        $0.setTitle("Выберите категорию", for: .normal)
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        
        print("init \(self)")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        print("deinit \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    func showError(_ error: CreateTransactionError) {
        showAlert(type: .error(error))
    }
    
    func setWallets(_ wallets: [WalletEntity]) {
        let actions = wallets.map { wallet in
            UIAction(title: wallet.title) { [weak self] _ in
                self?.pickedWalletHandle(wallet)
            }
        }
        showWalletMenuButton.menu = UIMenu(children: actions)
    }
    
    func setCategories(_ categories: [CategoryEntity]) {
        let actions = categories.map { category in
            let actionTitle = category.emoji + .space + category.title
            return UIAction(title: actionTitle) { [weak self] _ in
                self?.pickedCategoryHandle(category)
            }
        }
        showCategoryMenuButton.menu = UIMenu(children: actions)
    }
}

// MARK: - Subviews

private extension CreateTransactionView {
    func setupViews() {
        view.addSubviews(showWalletMenuButton, showCategoryMenuButton, amountLabel, amountTextField, walletLabel, categoryLabel)
    }
    
    func setupConstraints() {
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.verticalSpacingMedium)
            make.leading.equalToSuperview().inset(Constants.padding)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.padding)
            make.top.equalTo(amountLabel.snp.bottom).offset(Constants.verticalSpacingSmall)
            make.height.equalTo(Constants.textFieldHeight)
        }
        
        walletLabel.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(Constants.verticalSpacingMedium)
            make.leading.equalToSuperview().inset(Constants.padding)
        }
        
        showWalletMenuButton.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(Constants.verticalSpacingMedium)
            make.trailing.equalToSuperview().inset(Constants.padding)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(showWalletMenuButton.snp.bottom).offset(Constants.verticalSpacingMedium)
            make.leading.equalToSuperview().inset(Constants.padding)
        }
        
        showCategoryMenuButton.snp.makeConstraints { make in
            make.top.equalTo(showWalletMenuButton.snp.bottom).offset(Constants.verticalSpacingMedium)
            make.trailing.equalToSuperview().inset(Constants.padding)
        }
    }
    
    func setupNavigationBar() {
        view.backgroundColor = .systemBackground
        navigationItem.title = Strings.CreateTransaction.systemTitle
        
        let leftToolbarItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonPressed))
        
        let rightToolbarItem = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(addButtonPressed))
        
        navigationItem.leftBarButtonItem = leftToolbarItem
        navigationItem.rightBarButtonItem = rightToolbarItem
    }
}

// MARK: - Private Methods

private extension CreateTransactionView {
    @objc
    func closeButtonPressed() {
        output?.closeButtonDidPressed()
    }
    
    @objc
    func addButtonPressed() {
        guard let stringAmount = amountTextField.text,
              let amount = Double(stringAmount) else { return }
        
        output?.addButtonDidPressed(amount: amount)
    }
    
    func pickedWalletHandle(_ wallet: WalletEntity) {
        showWalletMenuButton.setTitle(wallet.title, for: .normal)
        output?.walletDidSelect(wallet)
    }
    
    func pickedCategoryHandle(_ category: CategoryEntity) {
        let title = category.emoji + .space + category.title
        showCategoryMenuButton.setTitle(title, for: .normal)
        output?.categoryDidSelect(category)
    }
}

// MARK: - Errors

enum CreateTransactionError: LocalizedError {
    case backend
    
    var errorDescription: String? {
        switch self {
        case .backend: Strings.Error.backend
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct CreateTransactionViewPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(
            rootViewController: CreateTransactionAssembly.createMock()
        ).asPreview()
    }
}
#endif
