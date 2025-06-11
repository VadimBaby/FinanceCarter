//
//  AppSpecificCoreDataFetcher.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation
import CoreData

public final class AppSpecificCoreDataFetcher {
    private let fetcher: CoreDataFetcher
    
    public init(fetcher: CoreDataFetcher) {
        self.fetcher = fetcher
    }
    
    // swiftlint:disable:next generic_constraint_naming
    public func fetch<Entity: NSManagedObject>(type: Entity.Type) throws -> [Entity] {
        try fetcher.fetch(type: type)
    }
    
    // swiftlint:disable:next generic_constraint_naming
    public func fetch<Entity: NSManagedObject>(by id: UUID, type: Entity.Type) throws -> Entity? {
        try fetcher.fetch(type: type) { request in
            request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            request.fetchLimit = 1
        }.first
    }
    
    // swiftlint:disable:next generic_constraint_naming
    public func fetch<Entity: NSManagedObject>(by date: Date, type: Entity.Type) throws -> Entity? {
        try fetcher.fetch(type: type) { request in
            request.predicate = NSPredicate(format: "date == %@", date as NSDate)
            request.fetchLimit = 1
        }.first
    }
    
    // swiftlint:disable:next generic_constraint_naming
    public func fetch<Entity: NSManagedObject>(by ids: [UUID], type: Entity.Type) throws -> [Entity] {
        try fetcher.fetch(type: type) { request in
            request.predicate = NSPredicate(format: "id IN %@", ids)
        }
    }
}
