//
//  WalletsUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import MyCommon

public typealias FetchWalletsCompletion = (_ result: Result<[WalletEntity], DomainError>) -> Void
public typealias UpdateWalletCompletion = (_ result: Result<WalletEntity, DomainError>) -> Void

public protocol WalletManagmentUseCase: AnyObject {
    func fetch(completion: @escaping FetchWalletsCompletion)
    func create(title: String, balance: Double, completion: @escaping UpdateWalletCompletion)
    func remove(_ wallet: WalletEntity, completion: @escaping UpdateWalletCompletion)
    func increaseBalance(by amount: Double, of wallet: WalletEntity, completion: @escaping UpdateWalletCompletion)
}
