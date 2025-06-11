//
//  TransactionSectionManagmentUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import MyCommon

public typealias FetchTransactionSectionsCompletion = (_ result: Result<[TransactionSectionEntity], DomainError>) -> Void
public typealias UpdateTransactionSectionCompletion = (_ result: Result<TransactionSectionEntity, DomainError>) -> Void

public protocol TransactionSectionManagmentUseCase: AnyObject {
    func fetch(completion: @escaping FetchTransactionSectionsCompletion)
    
    func fetch(by date: Date, completion: @escaping UpdateTransactionSectionCompletion)
    
    func create(
        with transactions: [TransactionEntity],
        date: Date,
        completion: @escaping UpdateTransactionSectionCompletion
    )
    
    func remove(_ section: TransactionSectionEntity, completion: @escaping UpdateTransactionSectionCompletion)
    
    func add(transactions: [TransactionEntity], to section: TransactionSectionEntity, completion: @escaping UpdateTransactionSectionCompletion)
}

extension TransactionSectionManagmentUseCase {
    func create(
        with transactions: [TransactionEntity],
        date: Date = .now,
        completion: @escaping UpdateTransactionSectionCompletion
    ) {
        create(with: transactions, date: date, completion: completion)
    }
}
