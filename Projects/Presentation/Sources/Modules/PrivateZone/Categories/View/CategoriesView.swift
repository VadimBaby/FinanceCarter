//
//  CategoriesView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol CategoriesViewOutput: AnyObject {
    
}

protocol CategoriesViewInput: AnyObject {
    var output: CategoriesViewOutput? { get set }
}

final class CategoriesView: UIViewController, CategoriesViewInput {
    var output: CategoriesViewOutput?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
