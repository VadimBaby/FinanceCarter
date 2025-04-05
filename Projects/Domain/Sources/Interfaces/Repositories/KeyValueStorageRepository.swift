//
//  KeyValueStorageRepository.swift
//  Domain
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

public protocol KeyValueStorageRepository: AnyObject {
    var isOnboardingCompleted: Bool { get set }
    var currentOnboardingPage: Int { get set }
    var userName: String { get set }
}
