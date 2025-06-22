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
import MyCommon
import Domain
import MyCoreDataWrapper

public final class CategoriesCoreDataSource: CategoriesLocalDataSource {
    private let store: CoreDataStorage
    
    public init(store: CoreDataStorage) {
        self.store = store
    }
    
    public func fetch() -> Result<[CategoryEntity], DataSourceError> {
        do {
            let entities = try store.fetch(type: DBCategory.self)
            let domainEntities = CategoryMapper.toDomain(from: entities)
            return .success(domainEntities)
        } catch {
            return .failure(.cannotFetch)
        }
    }
    
    public func create(_ category: CategoryEntity) -> OperationResult<DataSourceError> {
        do {
            try store.create(type: DBCategory.self) { entity in
                entity.id = category.id
                entity.title = category.title
                entity.emoji = category.emoji
                entity.type = category.type.rawValue
                entity.createdAt = category.createdAt
            }
            
            return .success
        } catch {
            return .failure(.cannotCreate)
        }
    }
    
    public func remove(by id: UUID) -> OperationResult<DataSourceError> {
        do {
            guard let entity = try store.fetch(by: id, type: DBCategory.self) else { return .success }
            try store.delete(entity: entity)
            return .success
        } catch {
            return .failure(.cannotRemove)
        }
    }
}
