//
//  HomePresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

protocol HomePresenterOutput: AnyObject {
    
}

protocol HomePresenterInput: AnyObject {
    var output: HomePresenterOutput? { get set }
}

final class HomePresenter: HomePresenterInput {
    weak var output: HomePresenterOutput?
    
    private weak var view: HomeViewInput?
    private let interactor: HomeInteractorInput
    
    init(view: HomeViewInput, interactor: HomeInteractorInput) {
        self.view = view
        self.interactor = interactor
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
}

extension HomePresenter: HomeViewOutput {
    
}

extension HomePresenter: HomeInteractorOutput {
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct HomePresenterPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: HomeModuleFactory.createMock()).asPreview()
    }
}
#endif
