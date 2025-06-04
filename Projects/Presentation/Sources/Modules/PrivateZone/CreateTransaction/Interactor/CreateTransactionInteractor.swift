//
//  CreateTransactionInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

protocol CreateTransactionInteractorOutput: AnyObject {
    func walletsDidGet(_ wallets: [WalletEntity])
    func categoriesDidGet(_ categories: [CategoryEntity])
    func throwError(_ error: CreateTransactionError)
    func walletDidAdded()
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
    
    private let transactionsUseCase: TransactionsUseCase
    private let walletsUseCase: WalletsUseCase
    private let categoryUseCase: CategoriesUseCase
    
    var selectedWallet: WalletEntity?
    var selectedCategory: CategoryEntity?

    // TODO: - Юзай фасад https://codeswift.ru/facade-design-pattern-in-swift/
    init(
        transactionsUseCase: TransactionsUseCase,
        walletsUseCase: WalletsUseCase,
        categoryUseCase: CategoriesUseCase
    ) {
        self.transactionsUseCase = transactionsUseCase
        self.walletsUseCase = walletsUseCase
        self.categoryUseCase = categoryUseCase
        
        print("init \(self)")
    }
    
    deinit {
        print("deinit \(self)")
    }
    
    func fetchWallets() {
        walletsUseCase.fetchWallets { [weak self] result in
            switch result {
            case .success(let entities):
                self?.output?.walletsDidGet(entities)
            case .failure(let error):
                debugPrint(error)
                self?.output?.throwError(.backend)
            }
        }
    }
    
    func fetchCategories() {
        categoryUseCase.fetchCategories { [weak self] result in
            switch result {
            case .success(let entities):
                self?.output?.categoriesDidGet(entities)
            case .failure(let error):
                debugPrint(error)
                self?.output?.throwError(.backend)
            }
        }
    }
    
    func addTransaction(amount: Double) {
        guard let category = selectedCategory,
              let wallet = selectedWallet else { output?.throwError(.backend); return }
        
        transactionsUseCase.addTransactions(category: category, wallet: wallet, amount: amount) { [weak self] result in
            switch result {
            case let .success(entity):
                self?.output?.walletDidAdded()
            case let .failure(error):
                self?.output?.throwError(.backend)
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
