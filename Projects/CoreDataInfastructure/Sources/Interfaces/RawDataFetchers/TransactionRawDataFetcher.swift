//
//  TransactionRawDataFetcher.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 07.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import CoreData
import Foundation

public protocol TransactionRawDataFetcher: AnyObject {
    func fetch(by id: UUID) throws -> DBTransaction?
    func fetch(by ids: [UUID]) throws -> [DBTransaction]
    func fetch() throws -> [DBTransaction]
}
