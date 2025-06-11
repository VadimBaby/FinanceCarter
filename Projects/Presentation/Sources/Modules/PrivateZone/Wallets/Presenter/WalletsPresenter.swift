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
import MyCommon

protocol WalletsPresenterOutput: AnyObject {
    func addButtonDidTap()
    func viewDidLoad(updateWalletsViewClosure: @escaping VoidAction)
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
        output?.viewDidLoad(updateWalletsViewClosure: interactor.getWallets)
        interactor.getWallets()
    }
    
    func addButtonDidPressed() {
        output?.addButtonDidTap()
    }
    
    func walletDidRemoved(_ wallet: WalletEntity) {
        interactor.removeWallet(wallet)
    }
}

extension WalletsPresenter: WalletsInteractorOutput {
    func walletsDidGet(_ wallets: [WalletEntity]) {
        view.setWallets(wallets)
    }
    
    func throwError(_ error: Error) {
        view.showError(error)
    }
    
    func removeWalletDidFall(_ wallet: WalletEntity) {
        view.insertWallet(wallet)
    }
}
