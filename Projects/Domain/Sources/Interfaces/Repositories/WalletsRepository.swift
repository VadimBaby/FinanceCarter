//
//  WalletsRepository.swift
//  Domain
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import MyCommon

public protocol WalletsRepositoryProtocol: AnyObject {
    func fetch(completion: @escaping (_ result: Result<[WalletEntity], DataError>) -> Void)
    
    func create(_ wallet: WalletEntity, completion: @escaping OperationResultCompletionWithDataError)
    
    func remove(by id: UUID, completion: @escaping OperationResultCompletionWithDataError)
    
    func set(
        balance: Double,
        for wallet: WalletEntity,
        completion: @escaping OperationResultCompletionWithDataError
    )
}
