//
//  MockTransactionSectionManagmentService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import MyCommon
import Foundation

public final class MockTransactionSectionManagmentService: TransactionSectionManagmentUseCase {
    public init() {}
    
    private var sections = [
        TransactionSectionEntity(date: .now.currentDayDate, transactions: [
            .init(category: .mock, wallet: .mock, amount: 133),
            .init(category: .mock, wallet: .mock, amount: 2500)
        ])
    ]
    
    public func fetch(completion: @escaping FetchTransactionSectionsCompletion) {
        completion(.success(sections))
    }
    
    public func fetch(by date: Date, completion: @escaping UpdateTransactionSectionCompletion) {
        guard let section = sections.first(where: { $0.date.currentDayDate == date.currentDayDate }) else {
            completion(.failure(.repository(.cannotFetch))); return
        }
        
        completion(.success(section))
    }
    
    public func create(
        with transactions: [TransactionEntity],
        date: Date,
        completion: @escaping UpdateTransactionSectionCompletion
    ) {
        let section = TransactionSectionEntity(date: date.currentDayDate, transactions: transactions)
        sections.append(section)
        completion(.success(section))
    }
    
    public func remove(_ section: TransactionSectionEntity, completion: @escaping UpdateTransactionSectionCompletion) {
        sections.removeAll(where: { $0.id == section.id })
        completion(.success(section))
    }
    
    public func add(transactions: [TransactionEntity], to section: TransactionSectionEntity, completion: @escaping UpdateTransactionSectionCompletion) {
        guard let index = sections.firstIndex(where: { $0.id == section.id }) else {
            completion(.failure(.repository(.cannotUpdate))); return
        }
        
        let new = section.copyWith(transactions: section.transactions + transactions)
        sections[index] = new
        completion(.success(new))
    }
}
