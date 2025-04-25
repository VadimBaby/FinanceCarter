//
//  CreateWalletView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 25.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol CreateWalletViewOutput: AnyObject {
    
}

protocol CreateWalletViewInput: AnyObject {
    var output: CreateWalletViewOutput? { get set }
}

final class CreateWalletView: UIViewController, CreateWalletViewInput {
    var output: CreateWalletViewOutput?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("\(Self.self) init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Private Methods

private extension CreateWalletView {
    func setupViews() {
        view.backgroundColor = .red
    }
}
