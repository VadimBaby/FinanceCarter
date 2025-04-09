//
//  TabBarController.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

protocol TabBarControllerProtocol: AnyObject {
    func setTab(viewController: UIViewController, for tab: TabBarItem)
}

enum TabBarItem: Int {
    case home, categories, transactions, wallets, profile
    
    var title: String {
        switch self {
        case .home: Strings.TabBar.home
        case .profile: Strings.TabBar.profile
        case .wallets: Strings.TabBar.wallets
        case .transactions: Strings.TabBar.transactions
        case .categories: Strings.TabBar.categories
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home: .houseIcon
        case .profile: .personIcon
        case .wallets: .walletIcon
        case .transactions: .menucardIcon
        case .categories: .documentIcon
        }
    }
    
    var tag: Int { rawValue }
}

final class TabBarController: UIAppTabBarController {
    func setTab(viewController: UIViewController, for tab: TabBarItem) {
        viewController.tabBarItem = UITabBarItem(title: tab.title, image: tab.image, tag: tab.tag)
        pushViewController(viewController)
    }
}
