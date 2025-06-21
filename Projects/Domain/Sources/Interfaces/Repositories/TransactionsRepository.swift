//
//  TransactionsRepository.swift
//  Domain
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import MyCommon

public protocol TransactionsRepositoryProtocol: AnyObject {
    func fetch(completion: @escaping (_ result: Result<[TransactionEntity], DataError>) -> Void)
    
    func create(
        _ transaction: TransactionEntity,
        completion: @escaping OperationResultCompletionWithDataError
    )
    
    func remove(by id: UUID, completion: @escaping OperationResultCompletionWithDataError)
}
