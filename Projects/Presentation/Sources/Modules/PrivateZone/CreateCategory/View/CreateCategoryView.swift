//
//  CreateCategoryView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 19.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import MyCommon
import SnapKit
import ElegantEmojiPicker

// MARK: - Constants

private struct Constants {
    static let pickEmojiButtonSize = 150
}

// MARK: - Contracts

protocol CreateCategoryViewOutput: AnyObject {
    func closeButtonDidPressed()
    func addButtonDidPressed(type: TypeSegmentedControlItem, title: String)
    func emojiDidPicked(_ emoji: String)
}

protocol CreateCategoryViewInput: AnyObject {
    var output: CreateCategoryViewOutput? { get set }
    
    func showError(_ error: Error)
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
    
    private lazy var pickEmojiButton = UIButton(type: .system) &> {
        $0.setTitle(Strings.CreateCategory.Button.pickEmojiButton, for: .normal)
        $0.addTarget(self, action: #selector(pickEmojiButtonPressed), for: .touchUpInside)
        $0.backgroundColor = .systemGroupedBackground
        $0.layer.cornerRadius = CGFloat(Constants.pickEmojiButtonSize / 2)
    }
    
    private lazy var titleLabel: UILabel = .placeholder(text: Strings.CreateCategory.Label.title)
    
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
    
    func showError(_ error: Error) {
        showAlert(type: .error(error))
    }
}

// MARK: - Subviews

private extension CreateCategoryView {
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubviews(pickEmojiButton, titleLabel, titleTextField, typeSegmentedControl)
    }
    
    func setupConstraints() {
        typeSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(AppConstants.verticalSpacingMedium)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.padding)
        }
        
        pickEmojiButton.snp.makeConstraints { make in
            make.top.equalTo(typeSegmentedControl.snp.bottom).offset(AppConstants.verticalSpacingMedium)
            make.centerX.equalToSuperview()
            make.size.equalTo(Constants.pickEmojiButtonSize)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(pickEmojiButton.snp.bottom).offset(AppConstants.verticalSpacingMedium)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.padding)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(AppConstants.padding)
            make.top.equalTo(titleLabel.snp.bottom).offset(AppConstants.verticalSpacingSmall)
            make.height.equalTo(AppConstants.textFieldHeight)
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
        }
    }
    
    @objc
    func mainViewTapped() {
        view.endEditing(true)
    }
    
    @objc
    func pickEmojiButtonPressed() {
        let configuration = ElegantConfiguration(showRandom: false)
        let picker = ElegantEmojiPicker(delegate: self, configuration: configuration)
        present(picker, animated: true)
    }
}

// MARK: - ElegantEmojiPickerDelegate

extension CreateCategoryView: ElegantEmojiPickerDelegate {
    func emojiPicker(_ picker: ElegantEmojiPicker, didSelectEmoji emoji: Emoji?) {
        guard let emoji else { return }
        
        let font = UIFont.systemFont(ofSize: CGFloat(Constants.pickEmojiButtonSize / 2))
        let attributedString = NSAttributedString(string: emoji.emoji, attributes: [.font: font])
        pickEmojiButton.setAttributedTitle(attributedString, for: .normal)
        output?.emojiDidPicked(emoji.emoji)
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
