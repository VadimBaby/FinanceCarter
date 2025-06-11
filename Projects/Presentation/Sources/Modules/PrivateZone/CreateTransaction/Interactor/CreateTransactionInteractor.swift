//
//  CreateTransactionInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import Foundation

protocol CreateTransactionInteractorOutput: AnyObject {
    func walletsDidGet(_ wallets: [WalletEntity])
    func categoriesDidGet(_ categories: [CategoryEntity])
    func throwError(_ error: Error)
    func transactionDidAdded()
}

protocol CreateTransactionInteractorInput: AnyObject {
    var output: CreateTransactionInteractorOutput? { get set }
    
    func fetchWallets()
    func fetchCategories()
    func walletDidSelect(_ wallet: WalletEntity)
    func categoryDidSelect(_ category: CategoryEntity)
    func addTransaction(amount: Double)
}

final class CreateTransactionInteractor: CreateTransactionInteractorInput {
    weak var output: CreateTransactionInteractorOutput?
    
    private let transactionManager: TransactionManaging
    private let walletsUseCase: WalletManagmentUseCase
    private let categoriesUseCase: CategoryManagmentUseCase
    
    private var selectedWallet: WalletEntity?
    private var selectedCategory: CategoryEntity?

    init(
        transactionManager: TransactionManaging,
        walletsUseCase: WalletManagmentUseCase,
        categoriesUseCase: CategoryManagmentUseCase
    ) {
        self.transactionManager = transactionManager
        self.walletsUseCase = walletsUseCase
        self.categoriesUseCase = categoriesUseCase
        
        print("init \(self)")
    }
    
    deinit {
        print("deinit \(self)")
    }
    
    private enum Error: LocalizedError {
        case invalidWalletOrCategory
        
        var errorDescription: String? {
            switch self {
            case .invalidWalletOrCategory: Strings.CreateTransaction.Error.invalidWalletOrCategory
            }
        }
    }
    
    func fetchWallets() {
        walletsUseCase.fetch { [weak self] result in
            switch result {
            case .success(let entities):
                self?.output?.walletsDidGet(entities)
            case .failure(let error):
                self?.output?.throwError(error)
            }
        }
    }
    
    func fetchCategories() {
        categoriesUseCase.fetch { [weak self] result in
            switch result {
            case .success(let entities):
                self?.output?.categoriesDidGet(entities)
            case .failure(let error):
                self?.output?.throwError(error)
            }
        }
    }
    
    func addTransaction(amount: Double) {
        guard let category = selectedCategory,
              let wallet = selectedWallet else { output?.throwError(Error.invalidWalletOrCategory); return }
        
        transactionManager.create(category: category, wallet: wallet, amount: amount) { [weak self] result in
            switch result {
            case .success:
                self?.output?.transactionDidAdded()
            case let .failure(error):
                self?.output?.throwError(error)
            }
        }
    }
    
    func walletDidSelect(_ wallet: WalletEntity) {
        selectedWallet = wallet
    }
    
    func categoryDidSelect(_ category: CategoryEntity) {
        selectedCategory = category
    }
}
