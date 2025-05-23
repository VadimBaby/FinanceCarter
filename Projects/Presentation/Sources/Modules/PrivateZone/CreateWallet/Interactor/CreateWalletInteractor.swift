//
//  CreateWalletInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 25.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import Common

protocol CreateWalletInteractorOutput: AnyObject {
    func walletDidAdded()
    func throwError(_ error: CreateWalletError)
}

protocol CreateWalletInteractorInput: AnyObject {
    var output: CreateWalletInteractorOutput? { get set }
    
    func addWallet(title: String, balance: String)
}

final class CreateWalletInteractor: CreateWalletInteractorInput {
    weak var output: CreateWalletInteractorOutput?
    
    private let useCase: WalletsUseCase
    
    init(useCase: WalletsUseCase) {
        self.useCase = useCase
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func addWallet(title: String, balance: String) {
        guard let doubleBalance = Double(balance),
              doubleBalance >= .zero else { output?.throwError(.balanceLessThanZero); return }
        
        useCase.addWallet(title: title, balance: doubleBalance) { [weak self] result in
            switch result {
            case .success:
                self?.output?.walletDidAdded()
            case .failure(let error):
                debugPrint(error)
                self?.output?.throwError(.backend)
            }
        }
    }
}
