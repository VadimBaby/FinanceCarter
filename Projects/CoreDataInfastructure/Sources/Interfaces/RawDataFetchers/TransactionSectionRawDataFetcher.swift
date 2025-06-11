//
//  TransactionSectionRawDataFetcher.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import CoreData

public protocol TransactionSectionRawDataFetcher: AnyObject {
    func fetch(by id: UUID) throws -> DBTransactionSection?
    func fetch() throws -> [DBTransactionSection]
    func fetch(by date: Date) throws -> DBTransactionSection?
}
