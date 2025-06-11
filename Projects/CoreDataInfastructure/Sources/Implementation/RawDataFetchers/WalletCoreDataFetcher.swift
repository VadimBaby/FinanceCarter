//
//  WalletsCoreDataFetcher.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation

public final class WalletCoreDataFetcher: WalletRawDataFetcher {
    private let fetcher: AppSpecificCoreDataFetcher
    
    public init(fetcher: AppSpecificCoreDataFetcher) {
        self.fetcher = fetcher
    }
    
    public func fetch() throws -> [DBWallet] {
        try fetcher.fetch(type: DBWallet.self)
    }
    
    public func fetch(by id: UUID) throws -> DBWallet? {
        try fetcher.fetch(by: id, type: DBWallet.self)
    }
}
