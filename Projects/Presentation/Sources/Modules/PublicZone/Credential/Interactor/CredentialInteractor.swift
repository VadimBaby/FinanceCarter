//
//  CredentialInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import Domain
import Common

protocol CredentialInteractorOutput: AnyObject {
    func nameDidSet(result: OperationResult)
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
        guard name.isNotEmpty else { return }
        let result = useCase.setName(name)
        output?.nameDidSet(result: result)
    }
}
