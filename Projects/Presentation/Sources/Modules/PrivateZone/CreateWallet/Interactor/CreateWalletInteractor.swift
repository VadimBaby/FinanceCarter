//
//  CreateWalletInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 25.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

protocol CreateWalletInteractorOutput: AnyObject {
    
}

protocol CreateWalletInteractorInput: AnyObject {
    var output: CreateWalletInteractorOutput? { get set }
}

final class CreateWalletInteractor: CreateWalletInteractorInput {
    weak var output: CreateWalletInteractorOutput?
    
    init() {
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
}
