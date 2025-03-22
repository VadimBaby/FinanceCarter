//
//  OnboardingItemViewController.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import SnapKit
import Common
import Domain

// MARK: - Delegate

protocol OnboardingItemViewControllerDelegate: AnyObject {
    func onboardingItemViewController(buttonPressed onboardingItemViewController: OnboardingItemViewController)
}

extension OnboardingItemViewControllerDelegate {
    func onboardingItemViewController(buttonPressed onboardingItemViewController: OnboardingItemViewController) {}
}

// MARK: - Contracts

protocol OnboardingItemViewControllerInput: AnyObject {
    var delegate: OnboardingItemViewControllerDelegate? { get set }
    var output: OnboardingItemViewControllerOutput? { get set }
    
    var page: Int { get }
    var image: UIImage { get }
    var mainTitle: String { get }
    var mainDescription: String { get }
    
    func changeButtonTitle()
}

protocol OnboardingItemViewControllerOutput: AnyObject {
    func configure(page: Int, image: UIImage, title: String, description: String)
    func changeButtonTitle()
    func updateConstrants()
}

// MARK: - OnboardingItemViewController

final class OnboardingItemViewController: UIViewController, OnboardingItemViewControllerInput {
    weak var delegate: OnboardingItemViewControllerDelegate?
    weak var output: OnboardingItemViewControllerOutput?
    
    let page: Int
    let image: UIImage
    let mainTitle: String
    let mainDescription: String
    
    private var isShouldChangeTitle = false
    
    init(
        page: Int,
        image: UIImage,
        title: String,
        description: String
    ) {
        self.page = page
        self.image = image
        self.mainTitle = title
        self.mainDescription = description
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let myView = OnboardingItemView()
        myView.output = self
        
        self.view = myView
        self.output = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.configure(page: page, image: image, title: mainTitle, description: mainDescription)
        
        if isShouldChangeTitle {
            output?.changeButtonTitle()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        output?.updateConstrants()
    }
    
    func changeButtonTitle() {
        if output.isNotNil {
            output?.changeButtonTitle()
        } else {
            isShouldChangeTitle = true
        }
    }
}

// MARK: - OnboardingItemViewOutput

extension OnboardingItemViewController: OnboardingItemViewOutput {
    func buttonPressed() {
        delegate?.onboardingItemViewController(buttonPressed: self)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct OnboardingItemViewPreview: PreviewProvider {
    static let mock = OnboardingItemEntity.mock

    static var previews: some View {
        OnboardingItemViewController(
            page: 0,
            image: mock.image,
            title: mock.title,
            description: mock.description
        ).asPreview()
    }
}
#endif

