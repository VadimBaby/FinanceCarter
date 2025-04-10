//
//  HomeFlowCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol HomeFlowCoordinatorOutput: AnyObject {
    func homeFlowCoordinatorDidStart(with viewController: UIViewController)
}

protocol HomeFlowCoordinatorInput: NavigationCoordinator {
    var delegate: HomeFlowCoordinatorOutput? { get set }
}

final class HomeFlowCoordinator: HomeFlowCoordinatorInput {
    weak var delegate: HomeFlowCoordinatorOutput?
    
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    
    typealias HomeRouterAssembly = (_ navigationController: UINavigationController, _ resolver: Resolver) -> HomeRouterInput
    
    private let homeRouterAssembly: HomeRouterAssembly
    
    private var homeRouter: HomeRouterInput?
    
    init(
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        homeRouterAssembly: @escaping HomeRouterAssembly
    ) {
        self.homeRouterAssembly = homeRouterAssembly
        
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        homeRouter = homeRouterAssembly(navigationController, resolver)
        homeRouter?.delegate = self
        homeRouter?.open()
        delegate?.homeFlowCoordinatorDidStart(with: navigationController)
    }
}

extension HomeFlowCoordinator: HomeRouterOutput {
    
}
