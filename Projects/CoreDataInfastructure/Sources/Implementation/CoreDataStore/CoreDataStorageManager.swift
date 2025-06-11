//
//  CoreDataStorageManager.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 22.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import CoreData
import MyCoreDataWrapper

private struct Constants {
    // swiftlint:disable:next identifier_name
    static let CORE_DATA_MODEL = "Model"
}

public class CoreDataStoreStorageManager: CoreDataStore, CoreDataFetcher {
    private let storage = CoreDataStorage()
    
    public init() {
        storage.setup(model: Constants.CORE_DATA_MODEL, bundle: type(of: self))
    }
    
    // swiftlint:disable:next generic_constraint_naming
    public func fetch<Entity: NSManagedObject>(type: Entity.Type) throws -> [Entity] {
        try storage.fetch(type: type)
    }
    
    // swiftlint:disable:next generic_constraint_naming
    public func fetch<Entity: NSManagedObject>(
        type: Entity.Type,
        configureRequest: (NSFetchRequest<Entity>) -> Void
    ) throws -> [Entity] {
        try storage.fetch(type: type, configureRequest: configureRequest)
    }
    
    // swiftlint:disable:next generic_constraint_naming
    public func delete<Entity: NSManagedObject>(entity: Entity) throws {
        try storage.delete(entity: entity)
    }
    
    // swiftlint:disable:next generic_constraint_naming
    public func create<Entity: NSManagedObject>(type: Entity.Type, configure: (Entity) -> Void) throws {
        try storage.create(type: type, configure: configure)
    }
    
    // swiftlint:disable:next generic_constraint_naming
    public func update<Entity: NSManagedObject>(entity: Entity, configure: (Entity) -> Void) throws {
        try storage.update(entity: entity, configure: configure)
    }
}
