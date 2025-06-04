//
//  TransactionTitleCellView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 28.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import SnapKit
import Reusable
import Domain
import Common

private struct Constants {
    static let padding = 10
    static let smallPadding = 5
}

final class TransactionTitleCellView: UITableViewCell, Reusable {
    private var walletTitle = UILabel() &> {
        $0.font = .preferredFont(forTextStyle: .caption1)
        $0.textColor = .gray
    }
    private var categoryTitle = UILabel() &> {
        $0.font = .preferredFont(forTextStyle: .title3)
    }
    
    private var amountTitle = UILabel()
    private var categoryEmoji = UILabel() &> {
        $0.font = .preferredFont(forTextStyle: .title1)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with transaction: TransactionEntity) {
        walletTitle.text = transaction.wallet.title
        categoryTitle.text = transaction.category.title
        amountTitle.text = buildAmountTitle(amount: transaction.amount, categoryType: transaction.category.type)
        categoryEmoji.text = transaction.category.emoji
    }
}

// MARK: - Subviews

extension TransactionTitleCellView {
    func setupViews() {
        contentView.addSubviews(walletTitle, categoryTitle, amountTitle, categoryEmoji)
    }
    
    func setupConstraints() {
        categoryEmoji.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.padding)
            make.top.equalToSuperview().offset(Constants.padding)
            make.bottom.equalToSuperview().inset(Constants.padding)
        }
        
        categoryTitle.snp.makeConstraints { make in
            make.leading.equalTo(categoryEmoji.snp.trailing).offset(Constants.padding)
            make.top.equalToSuperview().offset(Constants.smallPadding)
        }
        
        walletTitle.snp.makeConstraints { make in
            make.leading.equalTo(categoryEmoji.snp.trailing).offset(Constants.padding)
            make.top.equalTo(categoryTitle.snp.bottom).offset(Constants.smallPadding)
        }
        
        amountTitle.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constants.padding)
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: - Private Methods

private extension TransactionTitleCellView {
    func buildAmountTitle(amount: Double, categoryType type: CategoryType, currencySign: String = .rubleSign) -> String {
        type.sign + NumbersFormatter.formatWithMinimalDecimals(amount) + currencySign
    }
}
