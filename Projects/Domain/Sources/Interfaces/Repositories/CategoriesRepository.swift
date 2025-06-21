//
//  CategoriesRepository.swift
//  Domain
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import MyCommon

public protocol CategoriesRepositoryProtocol: AnyObject {
    func fetch(completion: @escaping (_ result: Result<[CategoryEntity], DataError>) -> Void)
    func create(_ category: CategoryEntity, completion: @escaping OperationResultCompletionWithDataError)
    func remove(by id: UUID, completion: @escaping OperationResultCompletionWithDataError)
}
