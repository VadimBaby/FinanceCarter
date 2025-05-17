//
//  WalletsRepository.swift
//  Domain
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Common

public protocol WalletsRepository: AnyObject {
    func fetchWallets(completion:  @escaping  (_ result: Result<[WalletEntity], Error>) -> Void)
    func addWallet(_ wallet: WalletEntity, completion:  @escaping  OperationResultCompletion)
    func removeWallet(by id: UUID, completion:  @escaping  OperationResultCompletion)
}
