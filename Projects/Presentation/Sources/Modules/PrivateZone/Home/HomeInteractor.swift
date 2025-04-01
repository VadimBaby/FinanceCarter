//
//  HomeInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

protocol HomeInteractorOutput: AnyObject {
    
}

protocol HomeInteractorInput: AnyObject {
    var output: HomeInteractorOutput? { get set }
}

final class HomeInteractor: HomeInteractorInput {
    weak var output: HomeInteractorOutput?
    
    init() {
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
}
