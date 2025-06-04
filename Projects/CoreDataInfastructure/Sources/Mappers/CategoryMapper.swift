//
//  CategoryMapper.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import CoreData

struct CategoryMapper {
    static func toDomain(from entity: DBCategory) -> CategoryEntity? {
        guard let type = CategoryType(rawValue: entity.type.orEmpty) else { return nil }
        
        return CategoryEntity(
            id: entity.id.orRandom,
            title: entity.title.orEmpty,
            emoji: entity.emoji.orEmpty,
            type: type,
            createdAt: entity.createdAt.orNow
        )
    }
    
    static func toDomain(from entities: [DBCategory]) -> [CategoryEntity] {
        entities.compactMap{ toDomain(from: $0) }.sorted(by: { $0.createdAt > $1.createdAt })
    }
}
