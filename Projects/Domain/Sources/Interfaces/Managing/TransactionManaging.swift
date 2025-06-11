//
//  TransactionManaging.swift
//  Domain
//
//  Created by Вадим Мартыненко on 07.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol TransactionManaging: AnyObject {
    func create(
        category: CategoryEntity,
        wallet: WalletEntity,
        amount: Double,
        completion: @escaping UpdateTransactionCompletion
    )
}
