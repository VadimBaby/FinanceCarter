//
//  CredentialPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import Common

protocol CredentialPresenterOutput: AnyObject {
    func didTapNext()
}

protocol CredentialPresenterInput: AnyObject {
    var output: CredentialPresenterOutput? { get set }
}

final class CredentialPresenter: CredentialPresenterInput {
    weak var output: CredentialPresenterOutput?
    
    private weak var view: CredentialViewInput?
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
        guard name.isNotEmpty else { return }
        output?.didTapNext()
    }
}

extension CredentialPresenter: CredentialInteractorOutput {
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct CredentialPresenterPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: CredentialModuleFactory.createMock()).asPreview()
    }
}
#endif
