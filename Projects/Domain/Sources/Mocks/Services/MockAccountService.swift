//
//  MockAccountService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 05.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Common

public final class MockAccountService: AccountUseCase {
    private var name: String = .empty
    
    public init() { }
    
    public func getUserName() -> String {
        name
    }
    
    @discardableResult
    public func setName(_ name: String) -> OperationResult {
        let clearName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard clearName.isNotEmpty else { return .failure(AccountUseCaseError.invalidName) }
        
        self.name = clearName
        return .success
    }
}
