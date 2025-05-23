//
//  CreateCategoryView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 19.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Common
import SnapKit

// MARK: - Constants

private struct Constants {
    static let padding = 20
    static let textFieldHeight = 50
    static let verticalSpacingSmall = 10
    static let verticalSpacingMedium = 20
}

// MARK: - Contracts

protocol CreateCategoryViewOutput: AnyObject {
    func closeButtonDidPressed()
    func addButtonDidPressed(type: TypeSegmentedControlItem, title: String)
}

protocol CreateCategoryViewInput: AnyObject {
    var output: CreateCategoryViewOutput? { get set }
    
    func showError(_ error: CreateCategoryViewError)
}

// MARK: - TypeSegmentedControlItems

enum TypeSegmentedControlItem: Int, CaseIterable {
    case income, spending
    
    var title: String {
        switch self {
        case .income: Strings.CreateCategory.Segment.income
        case .spending: Strings.CreateCategory.Segment.spending
        }
    }
    
    static func items() -> [String] {
        allCases.map{ $0.title }
    }
}

// MARK: View

final class CreateCategoryView: UIViewController, CreateCategoryViewInput {
    var output: CreateCategoryViewOutput?
    
    private let segmentedControlItems = TypeSegmentedControlItem.items()
    private lazy var typeSegmentedControl = UISegmentedControl(items: segmentedControlItems) &> {
        $0.selectedSegmentIndex = .zero
    }
    
    private lazy var titleLabel: UILabel = .textfield(text: Strings.CreateCategory.Label.title)
    
    private lazy var titleTextField: UITextField = .primary(placeholder: Strings.CreateCategory.Textfield.title)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("\(self) init")
    }
    
    deinit {
        print("\(self) deinit")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
        setupGestures()
    }
    
    func showError(_ error: CreateCategoryViewError) {
        showAlert(type: .error(error))
    }
}

// MARK: - Subviews

private extension CreateCategoryView {
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubviews(titleLabel, titleTextField, typeSegmentedControl)
    }
    
    func setupConstraints() {
        typeSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.verticalSpacingMedium)
            make.horizontalEdges.equalToSuperview().inset(Constants.padding)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(typeSegmentedControl.snp.bottom).offset(Constants.verticalSpacingMedium)
            make.horizontalEdges.equalToSuperview().inset(Constants.padding)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.padding)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.verticalSpacingSmall)
            make.height.equalTo(Constants.textFieldHeight)
        }
    }
    
    func setupNavigationBar() {
        navigationItem.title = Strings.CreateCategory.systemTitle
        
        let leftToolbarItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonPressed))
        
        let rightToolbarItem = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(addButtonPressed))
        
        navigationItem.leftBarButtonItem = leftToolbarItem
        navigationItem.rightBarButtonItem = rightToolbarItem
    }
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(mainViewTapped))
        
        view.addGestureRecognizer(tap)
    }
}

// MARK: - Private Methods

private extension CreateCategoryView {
    @objc
    func closeButtonPressed() {
        output?.closeButtonDidPressed()
    }
   
    @objc
    func addButtonPressed() {
        let currentIndex = typeSegmentedControl.selectedSegmentIndex
        
        if let segmentedItem = TypeSegmentedControlItem(rawValue: currentIndex),
           let textFieldValue = titleTextField.text {
            output?.addButtonDidPressed(type: segmentedItem, title: textFieldValue)
        } else {
            showError(.segmentOrTextFieldIsIncorrect)
        }
    }
    
    @objc
    func mainViewTapped() {
        view.endEditing(true)
    }
}

// MARK: - Errors

enum CreateCategoryViewError: LocalizedError {
    case segmentOrTextFieldIsIncorrect, backend
    
    var errorDescription: String? {
        switch self {
        case .segmentOrTextFieldIsIncorrect: Strings.CreateCategory.Error.segmentOrTextFieldIsIncorrect
        case .backend: Strings.Error.backend
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct CreateCategoryViewPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: CreateCategoryAssembly.createMock()).asPreview()
    }
}
#endif
