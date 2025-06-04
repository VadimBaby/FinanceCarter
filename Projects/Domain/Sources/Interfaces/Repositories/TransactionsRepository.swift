//
//  TransactionsRepository.swift
//  Domain
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Common

public protocol TransactionsRepository: AnyObject {
    func fetchTransactions(completion: @escaping (_ result: Result<[TransactionEntity], Error>) -> Void)
    func addTransaction(_ transaction: TransactionEntity, completion: @escaping  OperationResultCompletion)
    func removeTransaction(by id: UUID, completion: @escaping OperationResultCompletion)
}

