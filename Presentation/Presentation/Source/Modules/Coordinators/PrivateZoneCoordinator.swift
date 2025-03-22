//
//  PrivateZoneCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

protocol PrivateZoneCoordinatorInput: Coordinator {
    var tabBarController: UIAppTabBarController { get }
    
    func start(animated: Bool)
}

final class PrivateZoneCoordinator: PrivateZoneCoordinatorInput {
    var tabBarController: UIAppTabBarController
    
    private let window: UIWindow
    private let resolver: Resolver
    
    private let homeCoordinatorAssembly: (_ tabBarController: UIAppTabBarController, _ resolver: Resolver) -> TabBarItemCoordinator
    private let profileCoordinatorAssembly: (_ tabBarController: UIAppTabBarController, _ resolver: Resolver) -> TabBarItemCoordinator
    
    private var homeCoordinator: TabBarItemCoordinator?
    private var profileCoordinator: TabBarItemCoordinator?
    
    init(
        window: UIWindow,
        resolver: Resolver,
        tabBarController: UIAppTabBarController = TabBarController(),
        homeCoordinatorAssembly: @escaping (_ tabBarController: UIAppTabBarController, _ resolver: Resolver) -> TabBarItemCoordinator,
        profileCoordinatorAssembly: @escaping (_ tabBarController: UIAppTabBarController, _ resolver: Resolver) -> TabBarItemCoordinator
    ) {
        self.window = window
        self.resolver = resolver
        self.homeCoordinatorAssembly = homeCoordinatorAssembly
        self.profileCoordinatorAssembly = profileCoordinatorAssembly
        self.tabBarController = tabBarController
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        start(animated: false)
    }
    
    func start(animated: Bool) {
        homeCoordinator = homeCoordinatorAssembly(tabBarController, resolver)
        homeCoordinator?.start()
        
        profileCoordinator = profileCoordinatorAssembly(tabBarController, resolver)
        profileCoordinator?.start()
        
        window.setRootViewController(tabBarController, animated: animated)
    }
}
