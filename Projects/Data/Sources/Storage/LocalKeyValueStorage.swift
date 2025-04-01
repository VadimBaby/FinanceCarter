//
//  LocalKeyValueStorage.swift
//  Data
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import Common
import Domain
import Foundation

public final class LocalKeyValueStorage: KeyValueStorageRepository {
    private let storage = UserDefaults.standard
    
    private enum UserStorageKey: String {
        case isOnboardingCompleted, currentOnboardingPage
    }
    
    public init() {}
    
    public var isOnboardingCompleted: Bool {
        get {
            bool(forKey: .isOnboardingCompleted)
        } set {
            set(newValue, forKey: .isOnboardingCompleted)
        }
    }
    
    public var currentOnboardingPage: Int {
        get {
            integer(forKey: .currentOnboardingPage)
        } set {
            set(newValue, forKey: .currentOnboardingPage)
        }
    }
}

// MARK: - Private Methods

extension LocalKeyValueStorage {
    private func set(_ value: Any, forKey key: UserStorageKey) {
        storage.set(value, forKey: key.rawValue)
    }
    
    /// The Boolean value associated with the specified key. If the specified key doesn‘t exist, this method returns false.
    private func bool(forKey key: UserStorageKey) -> Bool {
        storage.bool(forKey: key.rawValue)
    }
    
    /// The integer value associated with the specified key. If the specified key doesn‘t exist, this method returns 0.
    private func integer(forKey key: UserStorageKey) -> Int {
        storage.integer(forKey: key.rawValue)
    }
}
