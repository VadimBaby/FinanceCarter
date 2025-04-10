//
//  HomeCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

protocol HomeRouterOutput: AnyObject {
    
}

protocol HomeRouterInput: Router {
    var delegate: HomeRouterOutput? { get set }
    
    typealias ModuleAssembly = (_ router: HomePresenterOutput, _ resolver: Resolver) -> UIViewController & HomeViewInput
    
    var moduleAssembly: ModuleAssembly? { get set }
    
    func open()
}

final class HomeRouter: HomeRouterInput {
    weak var delegate: HomeRouterOutput?
    
    private let resolver: Resolver
    let navigationController: UINavigationController
    
    var moduleAssembly: ModuleAssembly?
    
    init(
        navigationController: UINavigationController,
        resolver: Resolver
    ) {
        self.resolver = resolver
        self.navigationController = navigationController
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func open() {
        guard let view = moduleAssembly?(self, resolver) else { fatalError("moduleAssembly is nil in \(self)") }
        navigationController.pushViewController(view, animated: true)
    }
}

extension HomeRouter: HomePresenterOutput {
    
}
