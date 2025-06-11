//
//  TestFacade.swift
//  Domain
//
//  Created by Вадим Мартыненко on 07.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation

public final class TransactionManager: TransactionManaging {
    private let transactionsUseCase: TransactionManagmentUseCase
    private let transactionSectionsUseCase: TransactionSectionManagmentUseCase
    private let walletsUseCase: WalletManagmentUseCase
    
    public init(
        transactionsUseCase: TransactionManagmentUseCase,
        transactionSectionsUseCase: TransactionSectionManagmentUseCase,
        walletsUseCase: WalletManagmentUseCase
    ) {
        self.transactionsUseCase = transactionsUseCase
        self.walletsUseCase = walletsUseCase
        self.transactionSectionsUseCase = transactionSectionsUseCase
    }
    
    public func create(
        category: CategoryEntity,
        wallet: WalletEntity,
        amount: Double,
        completion: @escaping UpdateTransactionCompletion
    ) {
        transactionsUseCase.create(category: category, wallet: wallet, amount: amount) { [weak self] result in
            switch result {
            case let .success(transaction):
                guard let self = self else { completion(.failure(.repository(.cannotCreate))); return }
                
                self.addTransactionToSection(
                    transaction: transaction,
                    completion: completion
                )
                
                self.increaseBalance(
                    amount: amount,
                    wallet: wallet,
                    transaction: transaction,
                    completion: completion
                )
                
                completion(.success(transaction))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Private Methods

private extension TransactionManager {
    func increaseBalance(
        amount transactionAmount: Double,
        wallet: WalletEntity,
        transaction: TransactionEntity,
        completion: @escaping UpdateTransactionCompletion
    ) {
        let type = transaction.category.type
        
        var amount = transactionAmount
        
        if type == .spending {
            amount *= -1
        }
        
        walletsUseCase.increaseBalance(by: amount, of: wallet) { result in
            if case .failure(let error) = result {
                completion(.failure(error))
            }
        }
    }
    
    func addTransactionToSection(
        transaction: TransactionEntity,
        completion: @escaping UpdateTransactionCompletion
    ) {
        let date = transaction.createdAt.currentDayDate
        transactionSectionsUseCase.fetch(by: date) { [weak self] result in
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
        transactionSectionsUseCase.create(with: [transaction]) { result in
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
        transactionSectionsUseCase.add(transactions: [transaction], to: section) { result in
            if case .failure(let error) = result {
                completion(.failure(error))
            }
        }
    }
}
