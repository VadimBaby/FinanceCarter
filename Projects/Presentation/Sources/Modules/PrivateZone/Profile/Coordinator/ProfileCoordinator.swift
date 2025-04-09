//
//  ProfileCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import Swinject

final class ProfileCoordinator: TabBarItemCoordinator {
    private let resolver: Resolver
    
    var tabBarController: UIAppTabBarController
    var navigationController: UINavigationController
    
    private let profileAssembly: (_ coordinator: ProfilePresenterOutput, _ resolver: Resolver) -> UIViewController & ProfileViewInput
    
    init(
        tabBarController: UIAppTabBarController,
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        profileAssembly: @escaping (_ coordinator: ProfilePresenterOutput, _ resolver: Resolver) -> UIViewController & ProfileViewInput
    ) {
        self.tabBarController = tabBarController
        self.profileAssembly = profileAssembly
        
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        let view = profileAssembly(self, resolver)
        
        navigationController.setRootViewController(view)
        tabBarController.setTab(viewController: navigationController, for: .profile)
    }
}

extension ProfileCoordinator: ProfilePresenterOutput {
    
}
