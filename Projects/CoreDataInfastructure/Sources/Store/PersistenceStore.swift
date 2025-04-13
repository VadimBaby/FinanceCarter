//
//  PersistenceStore.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 14.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import CoreData

public final class PersistenceStore {
    public let persistenceContainer: NSPersistentContainer
    
    public init(model: String) {
        self.persistenceContainer = NSPersistentContainer(name: model)
        self.persistenceContainer.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}
