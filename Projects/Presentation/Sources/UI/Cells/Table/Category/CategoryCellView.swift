//
//  CategoryTitleCellView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import SnapKit
import Domain
import Reusable

final class CategoryCellView: UITableViewCell, Reusable {
    private var categoryTitle = UILabel()
    private var categoryType = UILabel()
    private var categoryEmoji = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: CategoryEntity) {
        categoryTitle.text = category.title
        categoryEmoji.text = category.emoji
        
        switch category.type {
        case .income: categoryType.text = Strings.CategoryCell.CategoryType.income
        case .spending: categoryType.text = Strings.CategoryCell.CategoryType.spending
        }
    }
}

// MARK: - Setups Views

private extension CategoryCellView {
    func setupViews() {
        contentView.addSubviews(categoryEmoji, categoryTitle, categoryType)
    }
    
    func setupConstraints() {
        categoryEmoji.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(AppConstants.innerPadding)
            make.centerY.equalToSuperview()
        }
        
        categoryTitle.snp.makeConstraints { make in
            make.leading.equalTo(categoryEmoji.snp.trailing).offset(AppConstants.innerPadding)
            make.centerY.equalToSuperview()
        }
        
        categoryType.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(AppConstants.innerPadding)
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: - Private Methods

private extension CategoryCellView {
    func string(from type: CategoryType) -> String {
        switch type {
        case .income: Strings.CategoryTitleCell.CategoryType.income
        case .spending: Strings.CategoryTitleCell.CategoryType.spending
        }
    }
}
