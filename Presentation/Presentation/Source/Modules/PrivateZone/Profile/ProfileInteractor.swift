//
//  ProfileInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

protocol ProfileInteractorOutput: AnyObject {
    
}

protocol ProfileInteractorInput: AnyObject {
    var output: ProfileInteractorOutput? { get set }
}

final class ProfileInteractor: ProfileInteractorInput {
    weak var output: ProfileInteractorOutput?
    
    init() {
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
}

