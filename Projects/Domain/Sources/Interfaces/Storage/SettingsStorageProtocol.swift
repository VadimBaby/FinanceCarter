//
//  SettingsStorageProtocol.swift
//  Domain
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol SettingsStorageProtocol: AnyObject {
    var isOnboardingCompleted: Bool { get set }
    var currentOnboardingPage: Int { get set }
    var userName: String { get set }
    var isPublicZoneCompleted: Bool { get set }
}
