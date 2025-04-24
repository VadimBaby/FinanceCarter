//
//  OnboardingView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import SnapKit
import Common
import Domain

protocol OnboardingViewOutput: AnyObject {
    func viewDidLoad()
    func viewDidConfigure()
    func buttonPressed(from page: Int)
    func pageSwiped(to page: Int)
}

protocol OnboardingViewInput: AnyObject {
    var output: OnboardingViewOutput? { get set }
    
    func configure(with items: [OnboardingItemPresentationEntity])
    func presentItem(with page: Int)
    func changeButtonTitle(at page: Int)
}

final class OnboardingView: UIPageViewController, OnboardingViewInput {
    var output: OnboardingViewOutput?
    
    private var itemsViewControllers: [OnboardingItemViewController] = []
    
    private lazy var pageControl = UIPageControl() &> {
        $0.currentPage = 0
        $0.numberOfPages = 3
        $0.currentPageIndicatorTintColor = .blue
        $0.pageIndicatorTintColor = .gray
    }
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
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
        output?.viewDidLoad()
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func configure(with items: [OnboardingItemPresentationEntity]) {
        itemsViewControllers = mapToOnboardingViewController(items)
        output?.viewDidConfigure()
    }
    
    func presentItem(with page: Int) {
        let viewController = itemsViewControllers[page]
        setViewController(viewController, animated: true, disableUserInteractionDuringAnimation: true)
    }
    
    func changeButtonTitle(at page: Int) {
        let viewController = itemsViewControllers[page]
        viewController.changeButtonTitle()
    }
}

// MARK: - Private Methods

private extension OnboardingView {
    func mapToOnboardingViewController(_ items: [OnboardingItemPresentationEntity]) -> [OnboardingItemViewController] {
        items.enumerated().map { index, item in
            let viewController = OnboardingItemViewController(
                page: index,
                image: item.image,
                title: item.title,
                description: item.description
            )
            
            viewController.delegate = self
            return viewController
        }
    }
    
    func setupViews() {
        view.backgroundColor = Asset.Colors.appBackgroundColor.color
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = true
        
        dataSource = self
        delegate = self
    }
}

// MARK: - OnboardingItemViewControllerDelegate

extension OnboardingView: OnboardingItemViewControllerDelegate {
    func onboardingItemViewController(buttonPressed onboardingItemViewController: OnboardingItemViewController) {
        output?.buttonPressed(from: onboardingItemViewController.page)
    }
}

// MARK: - UIPageViewControllerDelegate

extension OnboardingView: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed,
              let newVC = pageViewController.viewControllers?.first,
              let newVC = newVC as? OnboardingItemViewController,
              let index = itemsViewControllers.firstIndex(of: newVC) else { return }
        
        output?.pageSwiped(to: index)
    }
}

// MARK: - UIPageViewControllerDataSource

extension OnboardingView: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? OnboardingItemViewController else { fatalError() }
        
        guard let index = itemsViewControllers.firstIndex(of: viewController) else { return nil }
        
        let previousVC = itemsViewControllers[safe: index - 1]
        
        return previousVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? OnboardingItemViewController else { fatalError() }
        
        guard let index = itemsViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextVC = itemsViewControllers[safe: index + 1]
        
        return nextVC
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct OnboardingViewPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(
            rootViewController: OnboardingAssembly.createMock()
        ).asPreview()
    }
}
#endif
