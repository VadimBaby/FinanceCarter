//
//  CredentialPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import Common

protocol CredentialPresenterOutput: AnyObject {
    func credentialsDidTapNext()
}

protocol CredentialPresenterInput: AnyObject {
    var output: CredentialPresenterOutput? { get set }
}

final class CredentialPresenter: CredentialPresenterInput {
    weak var output: CredentialPresenterOutput?
    
    private unowned var view: CredentialViewInput
    private let interactor: CredentialInteractorInput
    
    init(view: CredentialViewInput, interactor: CredentialInteractorInput) {
        self.view = view
        self.interactor = interactor
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
}

extension CredentialPresenter: CredentialViewOutput {
    func didTapNextButton(name: String) {
        interactor.setName(name)
    }
}

extension CredentialPresenter: CredentialInteractorOutput {
    func nameDidSet(result: OperationResult) {
        switch result {
        case .success:
            output?.credentialsDidTapNext()
        case .failure:
            view.throwError(.emptyName)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct CredentialPresenterPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: CredentialAssembly.createMock()).asPreview()
    }
}
#endif
