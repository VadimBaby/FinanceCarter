//
//  DateAndAmountHeaderView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 01.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import SnapKit
import MyCommon
import Domain

final class TransactionTableHeaderView: UIView {
    private var dateLabel = UILabel()
    private var amountLabel = UILabel()
    
    func configure(with section: TransactionSectionEntity) {
        dateLabel.text = DateFomatter.toMonthAndDayString(from: section.date)
        amountLabel.text = .minusSign + NumbersFormatter.formatWithMinimalDecimals(section.spendingAmount).appendRubleSign()
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Subviews

private extension TransactionTableHeaderView {
    func setupViews() {
        backgroundColor = .tertiarySystemGroupedBackground
        addSubviews(dateLabel, amountLabel)
    }
    
    func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(AppConstants.smallPadding)
            make.leading.equalToSuperview().inset(AppConstants.innerPadding)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(AppConstants.smallPadding)
            make.trailing.equalToSuperview().inset(AppConstants.innerPadding)
        }
    }
}
