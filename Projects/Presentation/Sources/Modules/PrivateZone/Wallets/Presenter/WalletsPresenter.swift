//
//  WalletsPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain

protocol WalletsPresenterOutput: AnyObject {
    
}

protocol WalletsPresenterInput: AnyObject {
    var output: WalletsPresenterOutput? { get set }
}

final class WalletsPresenter: WalletsPresenterInput {
    weak var output: WalletsPresenterOutput?
    
    private let interactor: WalletsInteractorInput
    private unowned var view: WalletsViewInput
    
    init(interactor: WalletsInteractorInput, view: WalletsViewInput) {
        self.interactor = interactor
        self.view = view
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
}

extension WalletsPresenter: WalletsViewOutput {
    func viewDidLoad() {
        interactor.getAllWallets()
    }
    
    func addButtonHasPressed() {
        interactor.createNewWallet()
    }
    
    func walletHasDeleted(_ wallet: Wallet) {
        interactor.deleteWallet(wallet)
    }
}

extension WalletsPresenter: WalletsInteractorOutput {
    func setWallets(_ wallets: [Wallet]) {
        view.setWallets(wallets)
    }
}
