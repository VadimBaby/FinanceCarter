//
//  ProfileFlowCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Swinject

protocol ProfileFlowCoordinatorOutput: AnyObject {
    func profileFlowCoordinatorDidStart(with viewController: UIViewController)
}

protocol ProfileFlowCoordinatorInput: NavigationCoordinator {
    var delegate: ProfileFlowCoordinatorOutput? { get set }
}

final class ProfileFlowCoordinator: ProfileFlowCoordinatorInput {
    weak var delegate: ProfileFlowCoordinatorOutput?
    
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    
    typealias ProfileRouterAssembly = (_ navigationController: UINavigationController, _ resolver: Resolver) -> ProfileRouterInput
    
    private let profileRouterAssembly: ProfileRouterAssembly
    
    private var profileRouter: ProfileRouterInput?
    
    init(
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        profileRouterAssembly: @escaping ProfileRouterAssembly
    ) {
        self.profileRouterAssembly = profileRouterAssembly
        
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        profileRouter = profileRouterAssembly(navigationController, resolver)
        profileRouter?.delegate = self
        profileRouter?.open()
        delegate?.profileFlowCoordinatorDidStart(with: navigationController)
    }
}

extension ProfileFlowCoordinator: ProfileRouterOutput {
    
}
