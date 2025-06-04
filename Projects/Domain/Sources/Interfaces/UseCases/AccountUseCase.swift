//
//  AccountUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 05.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Common

public protocol AccountUseCase: AnyObject {
    func getUserName() -> String
    
    @discardableResult
    func setName(_ name: String) -> OperationResult<AccountUseCaseError>
}
