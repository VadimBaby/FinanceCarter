//
//  CategoriesInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

protocol CategoriesInteractorOutput: AnyObject {
    
}

protocol CategoriesInteractorInput: AnyObject {
    var output: CategoriesInteractorOutput? { get set }
}

final class CategoriesInteractor: CategoriesInteractorInput {
    weak var output: CategoriesInteractorOutput?
    
    init() {
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
}
