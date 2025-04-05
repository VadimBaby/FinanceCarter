//
//  AccountService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 05.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Common

public final class AccountService: AccountUseCase {
    private let repository: KeyValueStorageRepository
    
    public init(repository: KeyValueStorageRepository) {
        self.repository = repository
    }
    
    public func getUserName() -> String {
        repository.userName
    }
    
    public func setName(_ name: String, completion: IsSuccessCompletion? = nil) {
        let clearName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if clearName.isEmpty {
            completion?(false)
        } else {
            repository.userName = clearName
            completion?(true)
        }
    }
}
