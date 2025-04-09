//
//  WalletsInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol WalletsInteractorOutput: AnyObject {
    
}

protocol WalletsInteractorInput: AnyObject {
    var output: WalletsInteractorOutput? { get set }
}

final class WalletsInteractor: WalletsInteractorInput {
    weak var output: WalletsInteractorOutput?
    
    init() {
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
}
