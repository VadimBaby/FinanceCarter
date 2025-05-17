//
//  CreateWalletView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 25.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Common
import SnapKit

private struct Constants {
    static let padding = 20
    static let textFieldHeight = 50
    static let verticalSpacingSmall = 10
    static let verticalSpacingMedium = 20
}

protocol CreateWalletViewOutput: AnyObject {
    func closeButtonDidPressed()
    func addButtonDidPressed(title: String, balance: String)
}

protocol CreateWalletViewInput: AnyObject {
    var output: CreateWalletViewOutput? { get set }
    
    func showError(_ error: Error)
}

final class CreateWalletView: UIViewController, CreateWalletViewInput {
    var output: CreateWalletViewOutput?
    
    private lazy var titleLabel: UILabel = .textfield(text: Strings.CreateWallet.Label.title)
    private lazy var titleTextField: UITextField = .primary(placeholder: Strings.CreateWallet.Label.title) &> {
        $0.delegate = self
    }
    
    private lazy var balanceLabel: UILabel = .textfield(text: Strings.CreateWallet.Label.balance)
    private lazy var balanceTextField: UITextField = .primary(placeholder: Strings.CreateWallet.Label.balance) &> {
        $0.delegate = self
        $0.keyboardType = .numberPad
    }
    
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
        setupConstraints()
        setupGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    func showError(_ error: Error) {
        showAlert(type: .unknown(error: error))
    }
}

// MARK: - Setup View

private extension CreateWalletView {
    func setupViews() {
        view.backgroundColor = .systemBackground
        navigationItem.title = Strings.Credential.systemTitle
        
        let leftToolbarItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonPressed))
        
        let rightToolbarItem = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(addButtonPressed))
        
        navigationItem.leftBarButtonItem = leftToolbarItem
        navigationItem.rightBarButtonItem = rightToolbarItem
        
        view.addSubviews(titleLabel, titleTextField, balanceLabel, balanceTextField)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.padding)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.verticalSpacingMedium)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.padding)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.verticalSpacingSmall)
            make.height.equalTo(Constants.textFieldHeight)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.padding)
            make.top.equalTo(titleTextField.snp.bottom).offset(Constants.verticalSpacingMedium)
        }
        
        balanceTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.padding)
            make.top.equalTo(balanceLabel.snp.bottom).offset(Constants.verticalSpacingSmall)
            make.height.equalTo(Constants.textFieldHeight)
        }
    }
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(mainViewTapped))
        view.addGestureRecognizer(tap)
    }
}

// MARK: - Private Methods

private extension CreateWalletView {
    @objc
    func closeButtonPressed() {
        output?.closeButtonDidPressed()
    }
    
    @objc
    func addButtonPressed() {
        guard let title = titleTextField.text,
              let balance = balanceTextField.text else { return }
        
        output?.addButtonDidPressed(title: title, balance: balance)
    }
    
    @objc
    func mainViewTapped() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension CreateWalletView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case titleTextField:
            balanceTextField.becomeFirstResponder()
        case balanceTextField:
            balanceTextField.resignFirstResponder()
        default:
            break
        }
        
        return true
    }
}

// MARK: - Preview
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct CreateWalletViewPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: CreateWalletAssembly.createMock()).asPreview()
    }
}
#endif
