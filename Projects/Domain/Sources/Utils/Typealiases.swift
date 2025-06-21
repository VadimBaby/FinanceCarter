//
//  typealiases.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public typealias FetchWalletsCompletion = (_ result: Result<[WalletEntity], DomainError>) -> Void
public typealias UpdateWalletCompletion = (_ result: Result<WalletEntity, DomainError>) -> Void

public typealias FetchCategoryCompletion = (_ result: Result<[CategoryEntity], DomainError>) -> Void
public typealias UpdateCategoryCompletion = (_ result: Result<CategoryEntity, DomainError>) -> Void

public typealias FetchTransactionsCompletion = (_ result: Result<[TransactionEntity], DomainError>) -> Void
public typealias UpdateTransactionCompletion = (_ result: Result<TransactionEntity, DomainError>) -> Void

public typealias FetchTransactionSectionsCompletion = (_ result: Result<[TransactionSectionEntity], DomainError>) -> Void
public typealias UpdateTransactionSectionCompletion = (_ result: Result<TransactionSectionEntity, DomainError>) -> Void
