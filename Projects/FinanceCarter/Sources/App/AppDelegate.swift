//
//  AppDelegate.swift
//  FinanceCarter
//
//  Created by Вадим Мартыненко on 04.02.2025.
//

import UIKit
import Swinject
import Presentation

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinatorInput?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let resolver = DIConfigurator.configure(
            with: [CoreDataInfastructureAssembly(), DataAssembly(), DomainAssembly()]
        )
        
        appCoordinator = AppCoordinatorFactory.create(window: window!, resolver: resolver)
        appCoordinator?.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }
}
