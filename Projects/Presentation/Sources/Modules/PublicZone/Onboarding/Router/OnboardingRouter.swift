//
//  OnboardingRouter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol OnboardingRouterOutput: AnyObject {
    func onboardingDidFinish()
}

protocol OnboardingRouterInput: Router {
    var delegate: OnboardingRouterOutput? { get set }
    
    typealias ModuleAssembly = (_ router: OnboardingPresenterOutput, _ resolver: Resolver) -> UIViewController & OnboardingViewInput
    
    var moduleAssembly: ModuleAssembly? { get set }
    
    func open()
}

final class OnboardingRouter: OnboardingRouterInput {
    weak var delegate: OnboardingRouterOutput?
    
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

extension OnboardingRouter: OnboardingPresenterOutput {
    func onboardingDidFinish() {
        delegate?.onboardingDidFinish()
    }
}
