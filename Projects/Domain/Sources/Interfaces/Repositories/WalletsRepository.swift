//
//  WalletsRepository.swift
//  Domain
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol WalletsRepository: AnyObject {
    func fetchWallets() throws -> [Wallet]
    func addWallet(from domainEntity: Wallet) throws
}
