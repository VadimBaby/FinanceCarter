//
//  CreateTransactionPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

protocol CreateTransactionPresenterInput: AnyObject {
    var output: CreateTransactionPresenterOutput? { get set }
}

protocol CreateTransactionPresenterOutput: AnyObject {
    func closeButtonDidPressed()
    func transactionDidAdded()
}

final class CreateTransactionPresenter: CreateTransactionPresenterInput {
    weak var output: CreateTransactionPresenterOutput?
    
    private let interactor: CreateTransactionInteractorInput
    private unowned let view: CreateTransactionViewInput
    
    init(interactor: CreateTransactionInteractorInput, view: CreateTransactionViewInput) {
        self.interactor = interactor
        self.view = view
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
}

extension CreateTransactionPresenter: CreateTransactionViewOutput {
    func viewDidLoad() {
        interactor.fetchWallets()
        interactor.fetchCategories()
    }
    
    func closeButtonDidPressed() {
        output?.closeButtonDidPressed()
    }
    
    func walletDidSelect(_ wallet: WalletEntity) {
        interactor.walletDidSelect(wallet)
    }
    
    func categoryDidSelect(_ category: CategoryEntity) {
        interactor.categoryDidSelect(category)
    }
    
    func addButtonDidPressed(amount: Double) {
        interactor.addTransaction(amount: amount)
    }
}

extension CreateTransactionPresenter: CreateTransactionInteractorOutput {
    func walletsDidGet(_ wallets: [WalletEntity]) {
        view.setWallets(wallets)
    }
    
    func categoriesDidGet(_ categories: [CategoryEntity]) {
        view.setCategories(categories)
    }
    
    func throwError(_ error: Error) {
        view.showError(error)
    }

    func transactionDidAdded() {
        output?.transactionDidAdded()
    }
}
