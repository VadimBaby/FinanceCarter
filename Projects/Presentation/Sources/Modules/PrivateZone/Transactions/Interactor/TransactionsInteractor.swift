//
//  TransactionsInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

protocol TransactionsInteractorOutput: AnyObject {
    func transactionSectionsDidGet(_ sections: [TransactionSectionEntity])
    func throwError(_ error: TransactionsViewError)
}

protocol TransactionsInteractorInput: AnyObject {
    var output: TransactionsInteractorOutput? { get set }
    
    func getTransactionSections()
}

final class TransactionsInteractor: TransactionsInteractorInput {
    weak var output: TransactionsInteractorOutput?
    
    private let useCase: TransactionsUseCase
    
    init(useCase: TransactionsUseCase) {
        self.useCase = useCase
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func getTransactionSections() {
        useCase.fetchSectionTransactions { [weak self] result in
            switch result {
            case let .success(sections):
                self?.output?.transactionSectionsDidGet(sections)
            case let .failure(error):
                debugPrint(error)
                self?.output?.throwError(.backend)
            }
        }
    }
}
