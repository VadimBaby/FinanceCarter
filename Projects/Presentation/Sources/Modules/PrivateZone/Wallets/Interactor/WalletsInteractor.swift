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
    func setWallets(_ wallets: [Wallet])
}

protocol WalletsInteractorInput: AnyObject {
    var output: WalletsInteractorOutput? { get set }
    
    func getAllWallets()
    func createNewWallet()
}

final class WalletsInteractor: WalletsInteractorInput {
    weak var output: WalletsInteractorOutput?
    
    private let useCase: WalletsUseCase
    
    private var wallets: [Wallet] = []
    
    init(useCase: WalletsUseCase) {
        self.useCase = useCase
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func getAllWallets() {
        let operationResult = useCase.fetchWallets()
        
        switch operationResult {
        case .success(let wallets):
            self.wallets = wallets
            output?.setWallets(wallets)
        case .failure(let error):
#warning("варнинг с алертом")
            return
        }
    }
    
    func createNewWallet() {
        let operationResult = useCase.addWallet(title: UUID().uuidString, balance: .random(in: 0...9999))
        
        switch operationResult {
        case .success(let wallet):
            self.wallets.append(wallet)
            output?.setWallets(wallets)
        case .failure(let error):
            #warning("варнинг с алертом")
            return
        }
    }
}
