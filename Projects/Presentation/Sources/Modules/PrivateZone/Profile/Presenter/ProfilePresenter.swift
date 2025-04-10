//
//  ProfilePresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

protocol ProfilePresenterOutput: AnyObject {
    
}

protocol ProfilePresenterInput: AnyObject {
    var output: ProfilePresenterOutput? { get set }
}

final class ProfilePresenter: ProfilePresenterInput {
    weak var output: ProfilePresenterOutput?
    
    private unowned var view: ProfileViewInput
    private let interactor: ProfileInteractorInput
    
    init(view: ProfileViewInput, interactor: ProfileInteractorInput) {
        self.view = view
        self.interactor = interactor
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
}

extension ProfilePresenter: ProfileViewOutput {
    
}

extension ProfilePresenter: ProfileInteractorOutput {
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ProfilePresenterPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: ProfileAssembly.createMock()).asPreview()
    }
}
#endif
