//
//  CredentialInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import Domain

protocol CredentialInteractorOutput: AnyObject {
    func didSetName(isSuccess: Bool)
}

protocol CredentialInteractorInput: AnyObject {
    var output: CredentialInteractorOutput? { get set }
    
    func setName(_ name: String)
}

final class CredentialInteractor: CredentialInteractorInput {
    weak var output: CredentialInteractorOutput?
    
    private let useCase: AccountUseCase
    
    init(useCase: AccountUseCase) {
        self.useCase = useCase
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func setName(_ name: String) {
        useCase.setName(name, completion: output?.didSetName)
    }
}
