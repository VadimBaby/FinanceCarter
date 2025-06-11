//
//  TransactionsInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import MyCommon

protocol TransactionsInteractorOutput: AnyObject {
    func transactionSectionsDidGet(_ sections: [TransactionSectionEntity])
    func throwError(_ error: Error)
}

protocol TransactionsInteractorInput: AnyObject {
    var output: TransactionsInteractorOutput? { get set }
    
    func getTransactionSections()
}

final class TransactionsInteractor: TransactionsInteractorInput {
    weak var output: TransactionsInteractorOutput?
    
    private let useCase: TransactionSectionManagmentUseCase
    
    private var currentSectionTransactions: [TransactionSectionEntity] = []
    
    init(useCase: TransactionSectionManagmentUseCase) {
        self.useCase = useCase
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func getTransactionSections() {
        useCase.fetch { [weak self] result in
            switch result {
            case let .success(sections):
                self?.currentSectionTransactions = sections
                self?.output?.transactionSectionsDidGet(sections)
            case let .failure(error):
                self?.output?.throwError(error)
            }
        }
    }
}
