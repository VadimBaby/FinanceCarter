//
//  TransactionSectionCoreDataFecther.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation

public final class TransactionSectionCoreDataFetcher: TransactionSectionRawDataFetcher {
    private let fetcher: AppSpecificCoreDataFetcher
    
    public init(fetcher: AppSpecificCoreDataFetcher) {
        self.fetcher = fetcher
    }
    
    public func fetch() throws -> [DBTransactionSection] {
        try fetcher.fetch(type: DBTransactionSection.self)
    }
    
    public func fetch(by id: UUID) throws -> DBTransactionSection? {
        try fetcher.fetch(by: id, type: DBTransactionSection.self)
    }
    
    public func fetch(by date: Date) throws -> DBTransactionSection? {
        try fetcher.fetch(by: date, type: DBTransactionSection.self)
    }
}
