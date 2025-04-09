//
//  TransactionsInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

protocol TransactionsInteractorOutput: AnyObject {
    
}

protocol TransactionsInteractorInput: AnyObject {
    var output: TransactionsInteractorOutput? { get set }
}

final class TransactionsInteractor: TransactionsInteractorInput {
    weak var output: TransactionsInteractorOutput?
    
    init() {
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
}
