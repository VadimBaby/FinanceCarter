//
//  CredentialRouter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol CredentialRouterOutput: AnyObject {
    func credentialDidFinish()
}

protocol CredentialRouterInput: Router {
    var delegate: CredentialRouterOutput? { get set }
    
    typealias ModuleAssembly = (_ router: CredentialPresenterOutput, _ resolver: Resolver) -> UIViewController & CredentialViewInput
    
    var moduleAssembly: ModuleAssembly? { get set }
    
    func open()
}

final class CredentialRouter: CredentialRouterInput {
    weak var delegate: CredentialRouterOutput?
    
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

extension CredentialRouter: CredentialPresenterOutput {
    func credentialsDidTapNext() {
        delegate?.credentialDidFinish()
    }
}
