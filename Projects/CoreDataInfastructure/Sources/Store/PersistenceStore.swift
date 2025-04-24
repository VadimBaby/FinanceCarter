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
        let bundle = Bundle(for: type(of: self))
        
        guard let modelURL = bundle.url(forResource: model, withExtension: "momd") else {
            fatalError("Failed to find model \(model) in bundle")
        }
        
        guard let objectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to load model from \(modelURL)")
        }
        
        self.container = NSPersistentContainer(name: model, managedObjectModel: objectModel)
        self.container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            debugPrint("Successfully loaded persistent store: \(description)")
        }
    }
}
