//
//  WalletsPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Foundation
import Domain

protocol WalletsPresenterOutput: AnyObject {
    func addButtonDidTap()
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
        output?.addButtonDidTap()
    }
    
    func walletHasDeleted(_ wallet: Wallet) {
        interactor.deleteWallet(wallet)
    }
}

extension WalletsPresenter: WalletsInteractorOutput {
    func setWallets(_ wallets: [Wallet]) {
        view.setWallets(wallets)
    }
    
    func throwError(_ error: Error) {
        view.showError(error)
    }
}
