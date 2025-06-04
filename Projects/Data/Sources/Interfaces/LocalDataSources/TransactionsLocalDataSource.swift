//
//  TransactionsLocalDataSource.swift
//  Data
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation
import Domain
import Common

public protocol TransactionsLocalDataSource: AnyObject {
    func fetchTransactions() -> Result<[TransactionEntity], Error>
    func addTransaction(_ transaction: TransactionEntity) -> OperationResult<Error>
    func removeTransaction(by id: UUID) -> OperationResult<Error>
}
