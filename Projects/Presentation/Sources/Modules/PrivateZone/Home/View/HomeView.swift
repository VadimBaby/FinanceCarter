//
//  HomeView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import SnapKit
import Common

private enum Constants {
    static let padding: CGFloat = 10
}

protocol HomeViewOutput: AnyObject {
    
}

protocol HomeViewInput: AnyObject {
    var output: HomeViewOutput? { get set }
}

final class HomeView: UIViewController, HomeViewInput {
    enum SectionKind: CaseIterable {
        case header, balance
    }
    
    var output: HomeViewOutput?
    
    private let sections = SectionKind.allCases
    
    private lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout()) &> {
        $0.contentInsetAdjustmentBehavior = .automatic
        $0.dataSource = self
        $0.register(cellType: HomeHeaderViewCell.self)
        $0.register(cellType: HomeBalanceViewCell.self)
        $0.backgroundColor = view.backgroundColor
    }
    
    typealias HomeHeaderAssembly = (_ homeHeaderView: HomeHeaderViewInput) -> HomeHeaderViewOutput
    
    private let homeHeaderAssembly: HomeHeaderAssembly
    
    init(homeHeaderAssembly: @escaping HomeHeaderAssembly) {
        self.homeHeaderAssembly = homeHeaderAssembly
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
    }
}

// MARK: - Private Methods

private extension HomeView {
    func setupViews() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(collectionView)
    }
    
    func setupConstaints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension HomeView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentSection = sections[indexPath.section]
        
        switch currentSection {
        case .header:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HomeHeaderViewCell.self)
            let presenter = homeHeaderAssembly(cell)
            cell.configure(with: presenter)
            return cell
        case .balance:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HomeBalanceViewCell.self)
            return cell
        }
    }
}

// MARK: - Setup UICollectionViewCompositionalLayout

private extension HomeView {
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [unowned self] section, _ in
            let currentSection = self.sections[section]
            
            switch currentSection {
            case .header:
                return createHeaderSection()
            case .balance:
                return createBalanceSection()
            }
        }
    }
}

// MARK: - Sections

private extension HomeView {
    func createHeaderSection() -> NSCollectionLayoutSection {
        let item: NSCollectionLayoutItem = .init(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(1)
            )
        )
        
        let group: NSCollectionLayoutGroup = .horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.3)
            ),
            subitem: item,
            count: 1
        )
        
        let section: NSCollectionLayoutSection = .init(group: group)
        section.contentInsets = .init(
            top: Constants.padding,
            leading: Constants.padding,
            bottom: .zero,
            trailing: Constants.padding
        )
        return section
    }
    
    func createBalanceSection() -> NSCollectionLayoutSection {
        let item: NSCollectionLayoutItem = .init(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group: NSCollectionLayoutGroup = .horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.6)
            ),
            subitem: item,
            count: 1
        )
        
        let section: NSCollectionLayoutSection = .init(group: group)
        return section
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct HomeViewPreview: PreviewProvider {
    static var previews: some View {
        HomeModuleFactory.createMock().asPreview()
    }
}
#endif
