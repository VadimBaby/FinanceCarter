//
//  TransactionsUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 28.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Common

public typealias TransactionsUseCaseCompletionManyEntities = (_ result: Result<[TransactionEntity], Error>) -> Void
public typealias TransactionsUseCaseCompletionOneEntity = (_ result: Result<TransactionEntity, Error>) -> Void

public protocol TransactionsUseCase: AnyObject {
    func fetchTransactions(completion: @escaping TransactionsUseCaseCompletionManyEntities)
    
    func fetchSectionTransactions(completion: @escaping (_ result: Result<[TransactionSectionEntity] , Error>) -> Void)
    
    func addTransactions(category: CategoryEntity, wallet: WalletEntity, amount: Double, completion: @escaping TransactionsUseCaseCompletionOneEntity)
    
    func removeTransaction(_ transaction: TransactionEntity, completion: @escaping TransactionsUseCaseCompletionOneEntity)
}
