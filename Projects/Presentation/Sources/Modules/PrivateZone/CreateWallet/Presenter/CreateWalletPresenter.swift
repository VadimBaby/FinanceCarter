//
//  CreateWalletPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 25.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import MyCommon
import Domain

protocol CreateWalletPresenterOutput: AnyObject {
    func closeButtonDidPressed()
    func walletDidAdded()
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
    func closeButtonDidPressed() {
        output?.closeButtonDidPressed()
    }
    
    func addButtonDidPressed(title: String, balance: String) {
        interactor.addWallet(title: title, balance: balance)
    }
}

// MARK: - CreateWalletInteractorOutput

extension CreateWalletPresenter: CreateWalletInteractorOutput {
    func walletDidAdded() {
        output?.walletDidAdded()
    }
    
    func throwError(_ error: Error) {
        view.showError(error)
    }
}
