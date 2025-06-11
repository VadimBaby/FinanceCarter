//
//  WalletsInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain

protocol WalletsInteractorOutput: AnyObject {
    func walletsDidGet(_ wallets: [WalletEntity])
    func throwError(_ error: Error)
    func removeWalletDidFall(_ wallet: WalletEntity)
}

protocol WalletsInteractorInput: AnyObject {
    var output: WalletsInteractorOutput? { get set }
    
    func getWallets()
    func removeWallet(_ wallet: WalletEntity)
}

final class WalletsInteractor: WalletsInteractorInput {
    weak var output: WalletsInteractorOutput?
    
    private let useCase: WalletManagmentUseCase
    
    init(useCase: WalletManagmentUseCase) {
        self.useCase = useCase
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func getWallets() {
        useCase.fetch { [weak self] result in
            switch result {
            case .success(let wallets):
                self?.output?.walletsDidGet(wallets)
            case .failure(let error):
                self?.output?.throwError(error)
            }
        }
    }
    
    func removeWallet(_ wallet: WalletEntity) {
        useCase.remove(wallet) { [weak self] result in
            guard case let .failure(error) = result else { return }
            self?.output?.throwError(error)
            self?.output?.removeWalletDidFall(wallet)
        }
    }
}
