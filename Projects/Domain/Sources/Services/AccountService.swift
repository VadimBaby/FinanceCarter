//
//  AccountService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 05.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Common

public final class AccountService: AccountUseCase {
    private let settingsStorage: SettingsStorageProtocol
    
    public init(settingsStorage: SettingsStorageProtocol) {
        self.settingsStorage = settingsStorage
    }
    
    public func getUserName() -> String {
        settingsStorage.userName
    }
    
    @discardableResult
    public func setName(_ name: String) -> OperationResult<AccountUseCaseError> {
        let clearName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard clearName.isNotEmpty else { return .failure(AccountUseCaseError.invalidName) }
        
        settingsStorage.userName = clearName
        return .success
    }
}

// TODO: - Сделать норм ошибки
/*
enum RepositoryError: LocalizedError {
    case first, second, third
}

enum UseCaseError: LocalizedError {
    case repository(error: RepositoryError), first, second, third
}
*/
