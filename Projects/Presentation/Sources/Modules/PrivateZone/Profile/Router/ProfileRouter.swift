//
//  ProfileCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import Swinject

protocol ProfileRouterOutput: AnyObject {
    
}

protocol ProfileRouterInput: Router {
    var delegate: ProfileRouterOutput? { get set }
    
    typealias ModuleAssembly = (_ router: ProfilePresenterOutput, _ resolver: Resolver) -> UIViewController & ProfileViewInput
    
    var moduleAssembly: ModuleAssembly? { get set }
    
    func open()
}

final class ProfileRouter: ProfileRouterInput {
    weak var delegate: ProfileRouterOutput?
    
    private let resolver: Resolver
    
    var navigationController: UINavigationController
    
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
        guard let module = moduleAssembly?(self, resolver) else { fatalError("moduleAssembly is nil in \(self)") }
        navigationController.pushViewController(module, animated: true)
    }
}

extension ProfileRouter: ProfilePresenterOutput {
    
}
