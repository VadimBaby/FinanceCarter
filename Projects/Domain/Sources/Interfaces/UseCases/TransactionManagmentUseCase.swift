//
//  TransactionsUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 28.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import MyCommon

public typealias FetchTransactionsCompletion = (_ result: Result<[TransactionEntity], DomainError>) -> Void
public typealias UpdateTransactionCompletion = (_ result: Result<TransactionEntity, DomainError>) -> Void

public protocol TransactionManagmentUseCase: AnyObject {
    func fetch(completion: @escaping FetchTransactionsCompletion)
    
    func create(category: CategoryEntity, wallet: WalletEntity, amount: Double, completion: @escaping UpdateTransactionCompletion)
    
    func remove(_ transaction: TransactionEntity, completion: @escaping UpdateTransactionCompletion)
}
