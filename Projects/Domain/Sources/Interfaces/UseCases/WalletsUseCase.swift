//
//  WalletsUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Common

public protocol WalletsUseCase: AnyObject {
    func fetchWallets() -> Result<[Wallet], Error>
    
    @discardableResult
    func addWallet(title: String, balance: Double) -> OperationResult
}
