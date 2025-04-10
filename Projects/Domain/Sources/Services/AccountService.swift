//
//  AccountService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 05.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Common

public final class AccountService: AccountUseCase {
    private let settingsStorage: SettingsStorageProtocol
    
    public init(settingsStorage: SettingsStorageProtocol) {
        self.settingsStorage = settingsStorage
    }
    
    public func getUserName() -> String {
        settingsStorage.userName
    }
    
    public func setName(_ name: String, completion: IsSuccessCompletion? = nil) {
        let clearName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if clearName.isEmpty {
            completion?(false)
        } else {
            settingsStorage.userName = clearName
            completion?(true)
        }
    }
}
