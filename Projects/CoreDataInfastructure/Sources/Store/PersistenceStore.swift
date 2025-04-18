//
//  PersistenceStore.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 14.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import CoreData

public final class PersistenceStore {
    public let container: NSPersistentContainer
    
    public var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    public init(model: String) {
        self.container = NSPersistentContainer(name: model)
        self.container.loadPersistentStores { _, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}
