//
//  CredentialView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import SnapKit
import Common

private struct Constants {
    static let padding = 10
    static let nextButtonHeight = 50
    static let nameTextFieldHeight = 50
}

protocol CredentialViewOutput: AnyObject {
    func didTapNextButton(name: String)
}

protocol CredentialViewInput: AnyObject {
    var output: CredentialViewOutput? { get set }
}

final class CredentialView: UIViewController, CredentialViewInput {
    var output: CredentialViewOutput?
    
    private lazy var nameTextField: UITextField = .primary(placeholder: Strings.Credential.Textfield.Name.placeholder) &> { $0.delegate = self }
    
    private lazy var nextButton: UIButton = .primary(title: Strings.App.next) &> {
        $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    var nextButtonBottomConstraint: Constraint?
    
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
        setupNotifications()
        
        nameTextField.becomeFirstResponder()
    }
}

// MARK: - Setups

private extension CredentialView {
    func setupViews() {
        navigationItem.title = Strings.Credential.systemTitle
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        
        view.addSubviews(nameTextField, nextButton)
    }
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(mainViewTapped))
        view.addGestureRecognizer(tap)
    }
    
    func setupConstaints() {
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Constants.padding)
            make.horizontalEdges.equalToSuperview().inset(Constants.padding)
            make.height.equalTo(Constants.nameTextFieldHeight)
        }
        
        nextButton.snp.makeConstraints { make in
            nextButtonBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Constants.nextButtonHeight).constraint
            make.horizontalEdges.equalToSuperview().inset(Constants.padding)
            make.height.equalTo(Constants.nextButtonHeight)
        }
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Private Methods

private extension CredentialView {
    @objc
    func keyboardWillShow(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.size.height
        
        self.nextButtonBottomConstraint?.update(inset: keyboardHeight)
        self.view.layoutIfNeeded()
    }
    
    @objc
    func keyboardWillHide(_ notification: NSNotification) {
        self.nextButtonBottomConstraint?.update(inset: Constants.padding)
        self.view.layoutIfNeeded()
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

// MARK: - Preview
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct CredentialViewPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: CredentialModuleFactory.createMock()).asPreview()
    }
}
#endif
