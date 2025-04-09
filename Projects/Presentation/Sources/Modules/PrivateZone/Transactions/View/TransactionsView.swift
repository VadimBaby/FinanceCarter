//
//  TransactionsView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import SnapKit
import Common

protocol TransactionsViewOutput: AnyObject {
    
}

protocol TransactionsViewInput: AnyObject {
    var output: TransactionsViewOutput? { get set }
}

final class TransactionsView: UIViewController, TransactionsViewInput {
    var output: TransactionsViewOutput?
    
    private lazy var textLabel = UILabel() &> {
        $0.text = "Transactions"
    }
    
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
    
    override func viewDidLoad() {
        view.addSubview(textLabel)
        
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
