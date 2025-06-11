//
//  CredentialInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import Domain
import MyCommon

protocol CredentialInteractorOutput: AnyObject {
    func nameDidSet()
    func throwError(_ error: Error)
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
        
        switch result {
        case .success:
            output?.nameDidSet()
        case .failure(let error):
            output?.throwError(error)
        }
    }
}
