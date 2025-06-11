//
//  MockTransactionsService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 28.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class MockTransactionManagmentService: TransactionManagmentUseCase, TransactionManaging {
    private var transactions: Set<TransactionEntity> = [
        .init(category: .mock, wallet: .mock, amount: 155),
        .init(category: .mock, wallet: .mock, amount: 1699)
    ]
    
    private lazy var transactionSections: [TransactionSectionEntity] = [
        .init(date: .now, transactions: Array(transactions))
    ]
    
    public init() {}
    
    public func fetch(completion: @escaping FetchTransactionsCompletion) {
        let array = Array(transactions)
        let sortedArray = array.sortedByCreatedAt()
        completion(.success(sortedArray))
    }
    
    public func create(category: CategoryEntity, wallet: WalletEntity, amount: Double, completion: @escaping UpdateTransactionCompletion) {
        let transaction = TransactionEntity(category: category, wallet: wallet, amount: amount)
        transactions.insert(transaction)
        completion(.success(transaction))
    }
    
    public func remove(_ transaction: TransactionEntity, completion: @escaping UpdateTransactionCompletion) {
        transactions.remove(transaction)
        completion(.success(transaction))
    }
}
