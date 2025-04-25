//
//  CreateWalletPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 25.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

protocol CreateWalletPresenterOutput: AnyObject {
    
}

protocol CreateWalletPresenterInput: AnyObject {
    var output: CreateWalletPresenterOutput? { get set }
}

final class CreateWalletPresenter: CreateWalletPresenterInput {
    weak var output: CreateWalletPresenterOutput?
    
    private let interactor: CreateWalletInteractorInput
    private unowned let view: CreateWalletViewInput
    
    init(interactor: CreateWalletInteractorInput, view: CreateWalletViewInput) {
        self.interactor = interactor
        self.view = view
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
}

// MARK: - CreateWalletViewOutput

extension CreateWalletPresenter: CreateWalletViewOutput {
    
}

// MARK: - CreateWalletInteractorOutput

extension CreateWalletPresenter: CreateWalletInteractorOutput {
    
}
