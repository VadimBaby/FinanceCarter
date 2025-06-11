//
//  TransactionSectionsRepository.swift
//  Domain
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import MyCommon

public protocol TransactionSectionsRepository: AnyObject {
    func fetch(completion: @escaping (_ result: Result<[TransactionSectionEntity], DataError>) -> Void)
    
    func fetch(by date: Date, completion: @escaping (_ result: Result<TransactionSectionEntity, DataError>) -> Void)
    
    func create(
        _ section: TransactionSectionEntity,
        completion: @escaping OperationResultCompletionWithDataError
    )
    
    func add(
        transactions: [TransactionEntity],
        to section: TransactionSectionEntity,
        completion: @escaping OperationResultCompletionWithDataError
    )
    
    func remove(
        by id: UUID,
        completion: @escaping OperationResultCompletionWithDataError
    )
}
