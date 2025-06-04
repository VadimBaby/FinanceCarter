//
//  WalletsUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Common

public typealias WalletsUseCaseCompletionManyEntities = (_ result: Result<[WalletEntity], Error>) -> Void
public typealias WalletsUseCaseCompletionOneEntity = (_ result: Result<WalletEntity, Error>) -> Void

// TODO: - Мейби назвать как то получше, чем просто WalletsUseCase?
public protocol WalletsUseCase: AnyObject {
    func fetchWallets(completion: @escaping WalletsUseCaseCompletionManyEntities)
    func addWallet(title: String, balance: Double, completion: @escaping WalletsUseCaseCompletionOneEntity)
    func removeWallet(_ wallet: WalletEntity, completion: @escaping WalletsUseCaseCompletionOneEntity)
}
