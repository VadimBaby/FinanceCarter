//
//  CredentialInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

protocol CredentialInteractorOutput: AnyObject {
    
}

protocol CredentialInteractorInput: AnyObject {
    var output: CredentialInteractorOutput? { get set }
}

final class CredentialInteractor: CredentialInteractorInput {
    weak var output: CredentialInteractorOutput?
    
    init() {
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
}
