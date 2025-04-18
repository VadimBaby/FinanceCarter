//
//  WalletsView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol WalletsViewOutput: AnyObject {
    
}

protocol WalletsViewInput: AnyObject {
    var output: WalletsViewOutput? { get set }
}

final class WalletsView: UIViewController, WalletsViewInput {
    var output: WalletsViewOutput? 
    
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

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct WalletsViewPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(
            rootViewController: WalletsAssembly.createMock()
        ).asPreview()
    }
}
#endif
