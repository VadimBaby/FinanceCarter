//
//  CategoriesCoreDataFetcher.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation

public final class CategoryCoreDataFetcher: CategoryRawDataFetcher {
    private let fetcher: AppSpecificCoreDataFetcher
    
    public init(fetcher: AppSpecificCoreDataFetcher) {
        self.fetcher = fetcher
    }
    
    public func fetch() throws -> [DBCategory] {
        try fetcher.fetch(type: DBCategory.self)
    }
    
    public func fetch(by id: UUID) throws -> DBCategory? {
        try fetcher.fetch(by: id, type: DBCategory.self)
    }
}
