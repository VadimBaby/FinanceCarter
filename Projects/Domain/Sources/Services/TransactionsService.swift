//
//  TransactionsService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class TransactionsService: TransactionsUseCase {
    private let repostitory: TransactionsRepository
    
    public init(repostitory: TransactionsRepository) {
        self.repostitory = repostitory
    }
    
    // TODO: - Может делать сортировку в repository??? (в таком случае избавимся от switch case)
    public func fetchTransactions(completion: @escaping TransactionsUseCaseCompletionManyEntities) {
        repostitory.fetchTransactions { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let transactions):
                let sorted = sortedTransactions(transactions)
                completion(.success(sorted))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchSectionTransactions(completion: @escaping (Result<[TransactionSectionEntity], Error>) -> Void) {
        repostitory.fetchTransactions { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(entities):
                let sorted = entities.sortedByCreatedAt()
                let sections = mapToSections(from: entities)
                completion(.success(sections))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    public func addTransactions(category: CategoryEntity, wallet: WalletEntity, amount: Double, completion: @escaping TransactionsUseCaseCompletionOneEntity) {
        let transaction = TransactionEntity(category: category, wallet: wallet, amount: amount)
        repostitory.addTransaction(transaction) { result in
            switch result {
            case .success:
                completion(.success(transaction))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    public func removeTransaction(_ transaction: TransactionEntity, completion: @escaping TransactionsUseCaseCompletionOneEntity) {
        repostitory.removeTransaction(by: transaction.id) { result in
            switch result {
            case .success:
                completion(.success(transaction))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Private Methods

private extension TransactionsService {
    func sortedTransactions(_ transactions: [TransactionEntity]) -> [TransactionEntity] {
        transactions.sortedByCreatedAt()
    }
    
    // TODO: - Наверное лучше будет создать DBTransactionSection в CoreData, чтобы каждый раз не сортировать это все
    func mapToSections(from transactions: [TransactionEntity]) -> [TransactionSectionEntity] {
        let sorted = transactions.sortedByCreatedAt()
        
        // TODO: - Подумать как можно улучшить этот алгоритм
        return sorted.reduce([TransactionSectionEntity]()) { result, transaction in
            var sections = result
            
            let day = transaction.createdAt.currentDayDate
            
            let categoryType = transaction.category.type
            
            var amount = Double.zero
            
            if categoryType == .spending {
                amount = transaction.amount * -1
            }
            
            if let sectionIndex = sections.firstIndex(where: { $0.date == day }) {
                let section = sections[sectionIndex]
                
                let newSection = section.copyWith(
                    amount: section.amount + amount,
                    transactions: section.transactions + [transaction]
                )
                sections[sectionIndex] = newSection
            } else {
                let section = TransactionSectionEntity(date: day, amount: amount, transactions: [transaction])
                sections.append(section)
            }
            
            return sections
        }
    }
}
