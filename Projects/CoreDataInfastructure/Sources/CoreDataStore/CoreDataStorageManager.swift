//
//  CoreDataStorageManager.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 22.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import CoreData

private struct Constants {
    // swiftlint:disable:next identifier_name
    static let CORE_DATA_MODEL = "Model"
}

public class CoreDataStore {
    public init() {}
    
    public let store = PersistenceStore(model: Constants.CORE_DATA_MODEL)
    
    public func saveContext() throws {
        try store.viewContext.save()
    }
    
    // swiftlint:disable:next generic_constraint_naming
    public func fetch<Entity: NSManagedObject>(type: Entity.Type) throws -> [Entity] {
        let request = NSFetchRequest<Entity>(entityName: "\(Entity.self)")
        return try store.viewContext.fetch(request)
    }
    
    // swiftlint:disable:next generic_constraint_naming
    public func delete<Entity: NSManagedObject>(entity: Entity) throws {
        store.viewContext.delete(entity)
        try saveContext()
    }
}
