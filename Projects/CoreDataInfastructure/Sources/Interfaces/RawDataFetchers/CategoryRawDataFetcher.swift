//
//  CategoryRawDataFetcher.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 07.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import CoreData
import Foundation

public protocol CategoryRawDataFetcher: AnyObject {
    func fetch(by id: UUID) throws -> DBCategory?
    func fetch() throws -> [DBCategory]
}
