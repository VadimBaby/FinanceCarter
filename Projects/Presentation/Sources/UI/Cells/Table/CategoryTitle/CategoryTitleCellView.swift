//
//  CategoryTitleCellView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

#warning("Why title!?")

import UIKit
import SnapKit
import Domain
import Reusable

private struct Constants {
    static let padding = 10
}

final class CategoryTitleCellView: UITableViewCell, Reusable {
    private lazy var categoryTitle = UILabel()
    private lazy var categoryType = UILabel()
    
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
        categoryType.text = category.type.rawValue
    }
}

// MARK: - Setups Views

private extension CategoryTitleCellView {
    func setupViews() {
        contentView.addSubviews(categoryTitle, categoryType)
    }
    
    func setupConstraints() {
        categoryTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.padding)
            make.centerY.equalToSuperview()
        }
        
        categoryType.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constants.padding)
            make.centerY.equalToSuperview()
        }
    }
}
