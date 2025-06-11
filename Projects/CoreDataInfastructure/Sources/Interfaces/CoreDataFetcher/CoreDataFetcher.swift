//
//  CoreDataFetcher.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 11.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import CoreData

public protocol CoreDataFetcher: AnyObject {
    // swiftlint:disable:next generic_constraint_naming
    func fetch<Entity: NSManagedObject>(type: Entity.Type) throws -> [Entity]
    
    // swiftlint:disable:next generic_constraint_naming
    func fetch<Entity: NSManagedObject>(
        type: Entity.Type,
        configureRequest: (_ request: NSFetchRequest<Entity>) -> Void
    ) throws -> [Entity]
}
