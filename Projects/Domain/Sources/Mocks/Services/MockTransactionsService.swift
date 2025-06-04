//
//  MockTransactionsService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 28.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class MockTransactionsService: TransactionsUseCase {
    private var transactions: Set<TransactionEntity> = [
        .init(category: .mock, wallet: .mock, amount: 155),
        .init(category: .mock, wallet: .mock, amount: 1699)
    ]
    
    private lazy var transactionSections: [TransactionSectionEntity] = [
        .init(date: .now, amount: 1333, transactions: Array(transactions))
    ]
    
    public init() {}
    
    public func fetchTransactions(completion: @escaping TransactionsUseCaseCompletionManyEntities) {
        let array = Array(transactions)
        let sortedArray = array.sortedByCreatedAt()
        completion(.success(sortedArray))
    }
    
    public func addTransactions(category: CategoryEntity, wallet: WalletEntity, amount: Double, completion: @escaping TransactionsUseCaseCompletionOneEntity) {
        let transaction = TransactionEntity(category: category, wallet: wallet, amount: amount)
        transactions.insert(transaction)
        completion(.success(transaction))
    }
    
    public func removeTransaction(_ transaction: TransactionEntity, completion: @escaping TransactionsUseCaseCompletionOneEntity) {
        transactions.remove(transaction)
        completion(.success(transaction))
    }
    
    public func fetchSectionTransactions(completion: @escaping (Result<[TransactionSectionEntity], Error>) -> Void) {
        completion(.success(transactionSections))
    }
}
