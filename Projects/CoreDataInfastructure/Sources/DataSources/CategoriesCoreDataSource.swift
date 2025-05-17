//
//  CategoriesLocalDataSource.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Data
import Common
import Domain

public final class CategoriesCoreDataSource: CoreDataStore, CategoriesLocalDataSource {
    public func fetchCategories() -> Result<[CategoryEntity], Error> {
        do {
            let entities = try fetch(type: DBCategory.self)
            let domainEntities = CategoryMapper.toDomain(from: entities)
            return .success(domainEntities)
        } catch {
            return .failure(error)
        }
    }
    
    public func addCategory(_ category: CategoryEntity) -> OperationResult {
        let newCategory = DBCategory(context: store.viewContext)
        newCategory.id = category.id
        newCategory.title = category.title
        newCategory.type = category.type.rawValue
        newCategory.createdAt = category.createdAt
        
        do {
            try saveContext()
            return .success
        } catch {
            return .failure(error)
        }
    }
    
    public func removeCategory(by id: UUID) -> OperationResult {
        do {
            let entities = try fetch(type: DBCategory.self)
            guard let entity = entities.first(where: { $0.id == id }) else { return .success }
            try delete(entity: entity)
            return .success
        } catch {
            return .failure(error)
        }
    }
}
