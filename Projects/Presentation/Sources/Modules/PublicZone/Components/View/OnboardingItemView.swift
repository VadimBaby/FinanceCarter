//
//  OnboardingItemView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import SnapKit
import MyCommon

// MARK: - Constants

private protocol ConstantsProtocol {
    static var pageControlHeight: Int { get }
    static var descriptionLabelTopPadding: Int { get }
    static var holderViewTopPadding: Int { get }
    static var multipliedBy: Double { get }
    static var nextButtonHeight: Int { get }
}

private enum Constants {
    enum Vertical: ConstantsProtocol {
        static let pageControlHeight = 10
        static let descriptionLabelTopPadding = 10
        static let holderViewTopPadding = 50
        static let multipliedBy = 0.5
        static let nextButtonHeight = 60
    }
    
    enum Horizontal: ConstantsProtocol {
        static let pageControlHeight = 10
        static let descriptionLabelTopPadding = 10
        static let holderViewTopPadding = 20
        static let multipliedBy = 0.3
        static let nextButtonHeight = 50
    }
}

// MARK: - Contracts

protocol OnboardingItemViewInput: AnyObject {
    var output: OnboardingItemViewOutput? { get set }
}

protocol OnboardingItemViewOutput: AnyObject {
    func buttonPressed()
}

// MARK: - Controller

final class OnboardingItemView: UIView, OnboardingItemViewInput {
    weak var output: OnboardingItemViewOutput?
    
    private lazy var mainImage = UIImageView() &> {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var contentHolderView = UIView() &> {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowRadius = 35
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
        $0.layer.masksToBounds = false
    }
    
    private lazy var titleLabel = UILabel() &> {
        $0.font = .my(font: .title)
        $0.textColor = Asset.Colors.titleTextColor.color
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    private lazy var descriptionLabel = UILabel() &> {
        $0.font = .my(font: .description)
        $0.textColor = Asset.Colors.descriptionTextColor.color
        $0.numberOfLines = 4
        $0.textAlignment = .center
    }
    
    private lazy var pageControl = UIPageControl() &> {
        $0.numberOfPages = 3
        $0.currentPage = 0
        $0.currentPageIndicatorTintColor = .blue
        $0.pageIndicatorTintColor = .gray
        $0.isUserInteractionEnabled = false
    }
    
    private lazy var nextButton: UIButton = .primary(title: Strings.Onboarding.Button.next) &> {
        $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func buttonPressed() {
        output?.buttonPressed()
    }
}

// MARK: - OnboardingItemViewControllerOutput

extension OnboardingItemView: OnboardingItemViewControllerOutput {
    func configure(
        page: Int,
        image: UIImage,
        title: String,
        description: String
    ) {
        pageControl.currentPage = page
        mainImage.image = image
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    func changeButtonTitle() {
        guard var configuration = nextButton.configuration,
              let attributedTitle = configuration.attributedTitle else { return }
        
        let mutableAttributedString = NSMutableAttributedString(attributedTitle)
        mutableAttributedString.mutableString.setString(Strings.Onboarding.Button.ready)
        
        configuration.attributedTitle = AttributedString(mutableAttributedString)
        
        nextButton.configuration = configuration
    }
    
    func updateConstrants() {
        setupConstraints()
    }
}

// MARK: - Setup Views

private extension OnboardingItemView {
    func setupViews() {
        backgroundColor = Asset.Colors.appBackgroundColor.color
        addSubviews(mainImage, contentHolderView)
        contentHolderView.addSubviews(titleLabel, descriptionLabel, pageControl, nextButton)
    }
    
    func setupConstraints() {
        resetConstaints()
        
        switch UIDevice.current.orientation {
        case .landscapeRight, .landscapeLeft:
            setupConstraints(with: Constants.Horizontal.self)
        default:
            setupConstraints(with: Constants.Vertical.self)
        }
    }
    
    func setupConstraints(with constants: ConstantsProtocol.Type) {
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(AppConstants.padding)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(constants.multipliedBy)
        }
        
        contentHolderView.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(constants.holderViewTopPadding)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(AppConstants.padding)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(AppConstants.padding)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(AppConstants.padding)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(constants.descriptionLabelTopPadding)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(AppConstants.padding)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).inset(-10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(constants.pageControlHeight)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentHolderView.snp.bottom).inset(AppConstants.padding)
            make.height.equalTo(constants.nextButtonHeight)
            make.width.equalToSuperview().inset(AppConstants.padding)
            make.centerX.equalToSuperview()
        }
    }

    private func resetConstaints() {
        [mainImage, contentHolderView, titleLabel, descriptionLabel, pageControl, nextButton].forEach {
            $0.snp.removeConstraints()
        }
    }
}
