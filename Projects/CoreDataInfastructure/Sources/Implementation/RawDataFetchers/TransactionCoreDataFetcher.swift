//
//  TransactionCoreDataFetcher.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation

public final class TransactionCoreDataFetcher: TransactionRawDataFetcher {
    private let fetcher: AppSpecificCoreDataFetcher
    
    public init(fetcher: AppSpecificCoreDataFetcher) {
        self.fetcher = fetcher
    }
    
    public func fetch() throws -> [DBTransaction] {
        try fetcher.fetch(type: DBTransaction.self)
    }
    
    public func fetch(by id: UUID) throws -> DBTransaction? {
       try fetcher.fetch(by: id, type: DBTransaction.self)
    }
    
    public func fetch(by ids: [UUID]) throws -> [DBTransaction] {
        try fetcher.fetch(by: ids, type: DBTransaction.self)
    }
}
