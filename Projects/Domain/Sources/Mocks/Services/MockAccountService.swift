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
    
    public func setName(_ name: String, completion: IsSuccessCompletion? = nil) {
        let clearName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if clearName.isEmpty {
            completion?(false)
        } else {
            self.name = clearName
            completion?(true)
        }
    }
}
