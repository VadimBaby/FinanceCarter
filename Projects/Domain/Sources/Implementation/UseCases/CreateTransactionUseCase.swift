//
//  CreateTransactionUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol CreateTransactionUseCaseProtocol: AnyObject {
    func execute(
        category: CategoryEntity,
        wallet: WalletEntity,
        amount: Double,
        completion: @escaping UpdateTransactionCompletion
    )
}

public final class CreateTransactionUseCase: CreateTransactionUseCaseProtocol {
    private let repository: TransactionsRepositoryProtocol
    
    private let increaseWalletBalanceUseCase: IncreaseWalletBalanceUseCaseProtocol
    private let fetchOneTransactionSectionUseCase: FetchOneTransactionSectionUseCaseProtocol
    private let createTransactionSectionUseCase: CreateTransactionSectionUseCaseProtocol
    private let addTransactionsToSectionUseCase: AddTransactionsToSectionUseCaseProtocol
    
    public init(
        increaseWalletBalanceUseCase: IncreaseWalletBalanceUseCaseProtocol,
        fetchOneTransactionSectionUseCase: FetchOneTransactionSectionUseCaseProtocol,
        createTransactionSectionUseCase: CreateTransactionSectionUseCaseProtocol,
        addTransactionsToSectionUseCase: AddTransactionsToSectionUseCaseProtocol,
        repository: TransactionsRepositoryProtocol
    ) {
        self.increaseWalletBalanceUseCase = increaseWalletBalanceUseCase
        self.fetchOneTransactionSectionUseCase = fetchOneTransactionSectionUseCase
        self.createTransactionSectionUseCase = createTransactionSectionUseCase
        self.addTransactionsToSectionUseCase = addTransactionsToSectionUseCase
        self.repository = repository
    }
    
    public func execute(
        category: CategoryEntity,
        wallet: WalletEntity,
        amount: Double,
        completion: @escaping UpdateTransactionCompletion
    ) {
        increaseBalance(amount: amount, wallet: wallet, type: category.type) { [weak self] result in
            switch result {
            case let .failure(error): completion(.failure(error))
            case let .success(updatedWallet):
                let transaction = TransactionEntity(
                    category: category,
                    wallet: updatedWallet,
                    amount: amount
                )
                
                self?.repository.create(transaction) { result in
                    switch result {
                    case let .failure(error): completion(.failure(.repository(error)))
                    case .success:
                        self?.addTransactionToSection(transaction: transaction, completion: completion)
                        
                        completion(.success(transaction))
                    }
                }
            }
        }
    }
}

// MARK: - Private Methods

private extension CreateTransactionUseCase {
    func increaseBalance(
        amount transactionAmount: Double,
        wallet: WalletEntity,
        type: CategoryType,
        completion: @escaping UpdateWalletCompletion
    ) {
        var amount = transactionAmount
        
        if type == .spending {
            amount *= -1
        }
        
        increaseWalletBalanceUseCase.execute(amount: amount, wallet: wallet, completion: completion)
    }
    
    func addTransactionToSection(
        transaction: TransactionEntity,
        completion: @escaping UpdateTransactionCompletion
    ) {
        let date = transaction.createdAt.currentDayDate
        
        fetchOneTransactionSectionUseCase.execute(date: date) { [weak self] result in
            switch result {
            case .failure:
                self?.createTransactionSection(with: transaction, completion: completion)
            case let .success(section):
                self?.addTransactions(to: section, transaction: transaction, completion: completion)
            }
        }
    }
    
    func createTransactionSection(
        with transaction: TransactionEntity,
        completion: @escaping UpdateTransactionCompletion
    ) {
        createTransactionSectionUseCase.execute(
            transactions: [transaction],
            date: .now
        ) { result in
            if case .failure(let error) = result {
                completion(.failure(error))
            }
        }
    }
    
    func addTransactions(
        to section: TransactionSectionEntity,
        transaction: TransactionEntity,
        completion: @escaping UpdateTransactionCompletion
    ) {
        addTransactionsToSectionUseCase.execute(
            transactions: [transaction],
            section: section
        ) { result in
            if case .failure(let error) = result {
                completion(.failure(error))
            }
        }
    }
}

