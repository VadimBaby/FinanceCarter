//
//  CredentialView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import SnapKit
import Common

protocol CredentialViewOutput: AnyObject {
    func didTapNextButton(name: String)
}

protocol CredentialViewInput: AnyObject {
    var output: CredentialViewOutput? { get set }
}

final class CredentialView: UIViewController, CredentialViewInput {
    var output: CredentialViewOutput?
    
    private lazy var nameTextField: UITextField = .primary(placeholder: Strings.Credential.Textfield.Name.placeholder) &> { $0.delegate = self }
    
    private lazy var button: UIButton = .primary(title: Strings.App.next) &> {
        $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
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
        super.viewDidLoad()
        setupViews()
        setupConstaints()
        setupGestures()
    }
}

// MARK: - Views

private extension CredentialView {
    func setupViews() {
        navigationItem.title = Strings.Credential.systemTitle
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        
        view.addSubviews(nameTextField, button)
    }
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(mainViewTapped))
        view.addGestureRecognizer(tap)
    }
    
    func setupConstaints() {
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
    }
    
    @objc
    func buttonPressed() {
        guard let value = nameTextField.text else { return }
        output?.didTapNextButton(name: value)
    }
    
    @objc
    func mainViewTapped() {
        nameTextField.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate

extension CredentialView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        buttonPressed()
        return false
    }
}

// MARK: - Previewz
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct CredentialViewPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: CredentialModuleFactory.createMock()).asPreview()
    }
}
#endif
