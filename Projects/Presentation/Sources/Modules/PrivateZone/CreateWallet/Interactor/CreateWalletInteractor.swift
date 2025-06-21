//
//  CreateWalletInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 25.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation
import Domain
import MyCommon

protocol CreateWalletInteractorOutput: AnyObject {
    func walletDidAdded()
    func throwError(_ error: Error)
}

protocol CreateWalletInteractorInput: AnyObject {
    var output: CreateWalletInteractorOutput? { get set }
    
    func addWallet(title: String, balance: String)
}

final class CreateWalletInteractor: CreateWalletInteractorInput {
    weak var output: CreateWalletInteractorOutput?
    
    private let useCase: CreateWalletUseCaseProtocol
    
    init(useCase: CreateWalletUseCaseProtocol) {
        self.useCase = useCase
        print("\(Self.self) init")
    }
    
    private enum Error: LocalizedError {
        case balanceLessThanZero
        
        var errorDescription: String? {
            switch self {
            case .balanceLessThanZero: Strings.CreateWallet.Error.balanceLessThanZero
            }
        }
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func addWallet(title: String, balance: String) {
        guard let doubleBalance = Double(balance),
              doubleBalance >= .zero else { output?.throwError(Error.balanceLessThanZero); return }
        
        useCase.execute(title: title, balance: doubleBalance) { [weak self] result in
            switch result {
            case .success:
                self?.output?.walletDidAdded()
            case .failure(let error):
                self?.output?.throwError(error)
            }
        }
    }
}
