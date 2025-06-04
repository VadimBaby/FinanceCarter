//
//  TransactionsPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import Common

protocol TransactionsPresenterOutput: AnyObject {
    func addButtonDidTap(updateTransactionsViewClosure: @escaping VoidAction)
}

protocol TransactionsPresenterInput: AnyObject {
    var output: TransactionsPresenterOutput? { get set }
}

final class TransactionsPresenter: TransactionsPresenterInput {
    weak var output: TransactionsPresenterOutput?
    
    private let interactor: TransactionsInteractorInput
    private unowned var view: TransactionsViewInput
    
    init(interactor: TransactionsInteractorInput, view: TransactionsViewInput) {
        self.interactor = interactor
        self.view = view
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
}

extension TransactionsPresenter: TransactionsViewOutput {
    func viewDidLoad() {
        interactor.getTransactionSections()
    }
    
    func addButtonDidPressed() {
        output?.addButtonDidTap(updateTransactionsViewClosure: { [weak self] in
            self?.interactor.getTransactionSections()
        })
    }
}

extension TransactionsPresenter: TransactionsInteractorOutput {
    func transactionSectionsDidGet(_ sections: [TransactionSectionEntity]) {
        view.setTransactionSections(sections)
    }
    
    func throwError(_ error: TransactionsViewError) {
        view.showError(error)
    }
}
